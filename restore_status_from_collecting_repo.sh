#!/bin/bash

set -e

if [ $UID -ne 0 ]
then
    echo "This script must be executed as root"
    exit 1
fi

if [ -z "$COLLECTING_REPO" ]
then
    echo "COLLECTING_REPO not set"
    exit 1
fi

if [ -z "$PKG_ARCH" ]
then
    echo "PKG_ARCH not set"
    exit 1
fi

if [ -z "$PACKAGING_BASE" ]
then
    echo "PACKAGING_BASE not set"
    exit 1
fi

COLLECTING_DIR="$COLLECTING_REPO/$PKG_ARCH"
STATE_DIR="$PACKAGING_BASE/state"
PKGDB="$STATE_DIR/pkgdb.xml"

if ! [ -d "$COLLECTING_DIR" ]
then
    echo "COLLECTING_REPO/PKG_ARCH does not exist"
    exit 1
fi

if ! [ -d "$STATE_DIR" ]
then
    mkdir -v "$STATE_DIR"
else
    rm -f "$STATE_DIR"/*
fi

# Make sure only latest versions exist
echo -n 'y' | make remove_old_collected_packages

declare -a TSL_PACKAGES
declare -a SRC_PACKAGES

for TSL_ARCHIVE in "$COLLECTING_DIR"/*
do
    if [ "$TSL_ARCHIVE" = '*' ]
    then
        break
    fi

    TSL_ARCHIVE_NAME="$(basename $TSL_ARCHIVE)"
    TSL_PKG="${TSL_ARCHIVE_NAME%-*_${PKG_ARCH}.tpm.tar}"
    SRC_PKG=$(make source_package_of_"${TSL_PKG}")

    VERSION="${TSL_ARCHIVE_NAME##*-}"
    VERSION="${VERSION%%_*}"

    YEAR="${VERSION%%.*}"
    SECOND="${VERSION##*.}"
    DAY="${VERSION#${YEAR}.}"
    DAY="${DAY%.${SECOND}}"

    TIMESTRING="$YEAR-1-1 +$DAY days -1 day +$SECOND seconds utc"

    echo "$TSL_PKG ("$(date -d "$TIMESTRING" +"%F %H:%M:%S %Z")" from $SRC_PKG)"

    touch -d "$TIMESTRING" "${STATE_DIR}/${TSL_PKG}_installed"
    touch -d "$TIMESTRING" "${STATE_DIR}/${TSL_PKG}_collected"
    touch -d "$TIMESTRING" "${STATE_DIR}/${SRC_PKG}_built"
    touch -d "$TIMESTRING" "${STATE_DIR}/${SRC_PKG}_clean_to_build"

    # Special status files
    case "$SRC_PKG" in
        harfbuzz)
            touch -d "$TIMESTRING" "${STATE_DIR}/freetype_without_harfbuzz"
            ;;
    esac

    # Add the package to the list
    TSL_PACKAGES+=("$TSL_PKG")
    SRC_PACKAGES+=("$SRC_PKG")
done

# Remove duplicate entries
IFS=$'\n' SRC_PACKAGES=($(sort <<< "${SRC_PACKAGES[*]}" | uniq))
unset IFS

# Recreate dummy packages and fake their status file
bash create_dummy_pkgs.sh
touch -d "1970-1-1 utc" "${STATE_DIR}/dummy_pkgs_created"

# Remove unnecessary dummy packages
echo -n 'y' | make remove_old_collected_packages

# Install all packages
tpm --install "${TSL_PACKAGES[@]}"

# Mark not directly referenced packages with a dev package as auto
declare -a WITH_DEV

for SRC_PKG in "${SRC_PACKAGES[@]}"
do
    HAS_DEV=0

    TSL_PKGS_OF_SRC=$(make tsl_packages_of_$SRC_PKG)

    for TSL_PKG in $TSL_PKGS_OF_SRC
    do
        if [ "${TSL_PKG##*-}" = "dev" ]
        then
            HAS_DEV=1
            break
        fi
    done

    if [ "$HAS_DEV" != "0" ]
    then
        for TSL_PKG in $TSL_PKGS_OF_SRC
        do
            if [ "${TSL_PKG##*-}" != "dev" ]
            then
                WITH_DEV+=("$TSL_PKG")
            fi
        done
    fi
done

declare -a CDEPS

for SRC_PKG in "${SRC_PACKAGES[@]}"
do
    for CDEP in $(make cdeps_installed_of_${SRC_PKG})
    do
            CDEPS+=("$CDEP")
    done
done

IFS=$'\n' CDEPS=($(sort <<<"${CDEPS[*]}" | uniq))
unset IFS

declare -a TO_MARK_AUTO

for TSL_PKG in "${WITH_DEV[@]}"
do
        NEEDED=0

        for CDEP in "${CDEPS[@]}"
        do
                if [ "$CDEP" = "$TSL_PKG" ]
                then
                        NEEDED=1
                        break
                fi
        done

        if [ "$NEEDED" = "0" ]
        then
                TO_MARK_AUTO+=("$TSL_PKG")
        fi
done

tpm --mark-auto "${TO_MARK_AUTO[@]}"

for TSL_PKG in "${TO_MARK_AUTO[@]}"
do
    rm "${STATE_DIR}/${TSL_PKG}_installed"
done

# Remove unneeded packages (should do nothing for now)
tpm --remove-unneeded

# Recreate the package database
tpmdb --db "$PKGDB" --create-from-directory "$COLLECTING_DIR"

echo "Everything was successful."
