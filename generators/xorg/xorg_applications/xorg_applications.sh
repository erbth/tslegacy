#!/bin/bash

set -e

EXEC_DIR="${PWD}/${BASH_SOURCE[-1]%/*}"
EXEC_DIR="${EXEC_DIR%/.}"
GENERATOR_DIR="${EXEC_DIR}"
RESOURCE_LOCATION="${EXEC_DIR%/generators/xorg/xorg_applications}"

. "${RESOURCE_LOCATION}/utils/bash_utils.sh"

enable_debug_from_cmdline "$@"

# Script configuration
INPUT="xorg_applications_packages.conf"
PKG_VERSIONS="xorg_applications_package_versions"
SRC_PKG_EXTENSION="xorg_applications.mk"
META_PACKAGE="xorg-applications-all-dev"

debug "EXEC_DIR:          $EXEC_DIR"
debug "GENERATOR_DIR:     $GENERATOR_DIR"
debug "RESOURCE_LOCATION: $RESOURCE_LOCATION"

# Functions for the different modes of operation
function retrieve_versions
{
    if ! [ -r "${GENERATOR_DIR}/${INPUT}" ]
    then
        error "${INPUT} does not exist"
        return 1
    fi

    declare -a PACKAGES

    while read -r LINE
    do
        LINE="${LINE%%#*}"
        KEY="${LINE%%:*}"
        VALUE="${LINE#${KEY}:}"

        case "$KEY" in
        "pkg")
            if [ -z "$VALUE" ]
            then
                error "Invalid package in ${INPUT}: \"$VALUE\""
                return 1
            else
                PACKAGES+=("$VALUE")
            fi
            ;;

        "base_url")
            if [ -z "$VALUE" ]
            then
                error "Invalid base url in ${INPUT}: \"$VALUE\""
                return 1
            else
                BASE_URL="$VALUE"
            fi
            ;;

        "")
            ;;

        *)
            error "Invalid key in ${INPUT}: \"$KEY\""
            return 1
        esac
    done < "${GENERATOR_DIR}/${INPUT}"

    debug "Packages to retrieve: ${PACKAGES[*]}"
    debug "Base url where they are hosted: $BASE_URL"

    declare -a VERSIONS
    declare -a COMPRESSIONS

    while read -r LINE
    do
        PKG=${LINE%-*}
        COMPRESSION=${LINE##*.}
        COMPRESSION=${COMPRESSION,,}
        VERSION=${LINE##*-}
        VERSION=${VERSION%.tar.*}

        debug "Candidate \"$PKG\": version $VERSION, compression $COMPRESSION"

        for (( i=0; i < ${#PACKAGES[@]}; i++))
        do
            if [ "${PACKAGES[i]}" = "$PKG" ]
            then
                debug "Matched ${PACKAGES[i]} (i=$i)"

                if [ "${VERSIONS[i]}" = "$VERSION" ]
                then
                    # Compare compression algorithms
                    if  { [ "${COMPRESSIONS[i]}" = "gz" ]  && [ "$COMPRESSION" = "bz2" ]; } || \
                        { [ "${COMPRESSIONS[i]}" = "gz" ]  && [ "$COMPRESSION" = "xz" ]; } || \
                        { [ "${COMPRESSIONS[i]}" = "bz2" ] && [ "$COMPRESSION" = "xz" ]; }
                    then
                        debug "    compression changed to $COMPRESSION"
                        COMPRESSIONS[i]="$COMPRESSION"
                    fi
                else
                    # Compare versions
                    c="$VERSION"
                    a="${VERSIONS[i]}"

                    while true
                    do
                        c1="${c%%.*}"
                        c="${c#${c1}}"
                        c="${c#.}"

                        a1="${a%%.*}"
                        a="${a#${a1}}"
                        a="${a#.}"

                        debug "c1: $c1, c: $c, a1: $a1, a: $a"

                        if [ -z "$c1" ]
                        then
                            break
                        elif [ "$c1" = "$a1" ]
                        then
                            continue
                        else
                            if [ -z "$a1" ] || [ "$c1" -gt "$a1" ]
                            then
                                debug "    version changed to $VERSION"

                                VERSIONS[i]="$VERSION"
                                COMPRESSIONS[i]="$COMPRESSION"
                                break
                            fi
                        fi
                    done
                fi
            fi
        done
    done < <(wget -O - "$BASE_URL" | \
        grep '<a href' | \
        sed 's/.*<a href[^>]*>\([^<]*\)<.*/\1/' | \
        grep -i -e '\(gz\|bz2\)$')

    for (( i=0; i < ${#PACKAGES[@]}; i++))
    do
        if [ -z "${VERSIONS[i]}" ] || [ -z "${COMPRESSIONS[i]}" ]
        then
            error "No source archive found for \"${PACKAGES[i]}\""
            return 1
        fi
    done

    # Generate the list of packages
    > "$GENERATOR_DIR/$PKG_VERSIONS"

    for (( i=0; i < ${#PACKAGES[@]}; i++))
    do
        info "Found ${PACKAGES[i]}-${VERSIONS[i]}.tar.${COMPRESSIONS[i]}"
        echo "${PACKAGES[i]}:${VERSIONS[i]}:${COMPRESSIONS[i]}" >> \
            "$GENERATOR_DIR/$PKG_VERSIONS"
    done

    return 0
}


# Generate the TSL packages
function generate_build_system
{
    if ! [ -r "$GENERATOR_DIR/$PKG_VERSIONS" ]
    then
        error "File \"$PKG_VERSIONS\" not found"
        return 1
    fi

    echo "SOURCE_PACKAGES += \\" > "$GENERATOR_DIR/$SRC_PKG_EXTENSION"

    # Collect the source packges' names to use them later
    declare -a PACKAGES

    while IFS=':' read -r PKG VERSION COMPRESSION
    do
        PACKAGES+=("$PKG")

        echo -e "\t$PKG \\" >> "$GENERATOR_DIR/$SRC_PKG_EXTENSION"

        PKG_DIR="$RESOURCE_LOCATION/$PKG"
        # Create directory
        debug "Creating directory $PKG_DIR"
        mkdir -p "$PKG_DIR"

        # Configure files
        echo "This file was generated by generators/xorg/xorg_applications." > "$PKG_DIR"/README

        sed -e "s/skel_version/$VERSION/g" \
            -e "s/skel_compression/$COMPRESSION/g"\
            -e "s/skel/$PKG/g" \
            "${GENERATOR_DIR}/description.mk.in" > "$PKG_DIR/description.mk"

        # Patch for luit
        if [ "$PKG" = "luit" ]
        then
            cp "${GENERATOR_DIR}"/patch_luit.sh.in "$PKG_DIR"/patch.sh.in
        fi

        # Let each package depend on its predecessor (important because of
        # compiletime dependencies)
        if [ -n "$PREV_PKG" ]
        then
            sed "/SRC_CDEPS/s/=/= ${PREV_PKG}-dev_installed/" -i \
                "$PKG_DIR/description.mk"
        fi

        sed -e "s/skel_version/$VERSION/g" \
            -e "s/skel_compression/$COMPRESSION/g"\
            -e "s/skel/$PKG/g" \
            "${GENERATOR_DIR}/Makefile.in" > "$PKG_DIR/Makefile"

        cp "${GENERATOR_DIR}"/adapt.sh.in "$PKG_DIR"/

        sed -e "s/skel_version/$VERSION/g" \
            -e "s/skel_compression/$COMPRESSION/g"\
            -e "s/skel/$PKG/g" \
            "${GENERATOR_DIR}/install_split.sh.in" > "$PKG_DIR/install_split.sh"

        chmod +x "$PKG_DIR/install_split.sh"

        cp "${GENERATOR_DIR}"/skel-dev_configure.sh.in "$PKG_DIR"/"$PKG"-dev_configure.sh.in

        sed -e "s/skel_version/$VERSION/g" \
            -e "s/skel_compression/$COMPRESSION/g"\
            -e "s/skel/$PKG/g" \
            "${GENERATOR_DIR}/skel_README.tslegacy.in.in" > "$PKG_DIR/${PKG}_README.tslegacy.in"

        sed -e "s/skel_version/$VERSION/g" \
            -e "s/skel_compression/$COMPRESSION/g"\
            -e "s/skel/$PKG/g" \
            "${GENERATOR_DIR}/skel-dev_README.tslegacy.in.in" > "$PKG_DIR/$PKG-dev_README.tslegacy.in"

        # Remember which packages was processed bevore the next one
        PREV_PKG="$PKG"
    done < <(cat "$GENERATOR_DIR/$PKG_VERSIONS")

    # Generate a meta package, which depends on all dev packages of Xorg
    # Applications
    PKG_DIR="$RESOURCE_LOCATION/$META_PACKAGE"
    debug "Creating directory $PKG_DIR"
    mkdir -p "$PKG_DIR"

    echo "This file was generated by generators/xorg/xorg_applications." > "$PKG_DIR"/README

    # Form compiletime and runtime dependencies
    for PKG in "${PACKAGES[@]}"
    do
        if [ -n "$META_CDEPS" ]
        then
            META_CDEPS="$META_CDEPS \\\\"$'\\\n\t'
        fi

        META_CDEPS="$META_CDEPS$PKG-dev_installed"

        if [ -n "$META_RDEPS" ]
        then
            META_RDEPS="$META_RDEPS \\\\"$'\\\n\t'
        fi

        META_RDEPS="$META_RDEPS"'$(call bigger_equal_dep,'"$PKG"'-dev)'
    done

    debug "Compiletime dependencies of the meta package: $META_CDEPS"
    debug "Runtime dependencies of the meta package: $META_RDEPS"

    sed -e "s/skel_cdeps/$META_CDEPS/g" \
        -e "s/skel_rdeps/$META_RDEPS/g" \
        -e "s/skel/$META_PACKAGE/g" \
        "${GENERATOR_DIR}/meta/description.mk.in" > "$PKG_DIR/description.mk"

    sed -e "s/skel/$META_PACKAGE/g" \
        "${GENERATOR_DIR}/meta/Makefile.in" > "$PKG_DIR/Makefile"

    install -m755 "${GENERATOR_DIR}/meta/install_split.sh" "$PKG_DIR/"

    sed -e "s/skel/$META_PACKAGE/g" \
        "${GENERATOR_DIR}/meta/skel-dev_README.tslegacy.in.in" \
        > "$PKG_DIR/${META_PACKAGE}_README.tslegacy.in"

    echo -e "\t$META_PACKAGE \\" >> "$GENERATOR_DIR/$SRC_PKG_EXTENSION"

    echo >> "$GENERATOR_DIR/$SRC_PKG_EXTENSION"
}

# Remove generated packages and one meta file
function clean_build_system
{
    if ! [ -r "$GENERATOR_DIR/$PKG_VERSIONS" ]
    then
        error "File \"$PKG_VERSIONS\" not found"
        return 1
    fi

    rm -rf "${GENERATOR_DIR}/${SRC_PKG_EXTENSION}"

    while IFS=':' read -r PKG VERSION COMPRESSION
    do
        rm -rf "${RESOURCE_LOCATION}/${PKG}"
    done < <(cat "$GENERATOR_DIR/$PKG_VERSIONS")

    rm -rf "$RESOURCE_LOCATION/$META_PACKAGE"
}

# Download the source packages
function download_source_packages
{
    if [ -z "$SOURCE_LOCATION" ]
    then
        error "SOURCE_LOCATION not set"
        return 1
    fi

    if ! [ -r "${GENERATOR_DIR}/${PKG_VERSIONS}" ]
    then
        error "The file \"${PKG_VERSIONS}\" cannot be read"
        return 1
    fi

    if ! [ -r "${GENERATOR_DIR}/${INPUT}" ]
    then
        error "The file \"${INPUT}\" cannot be read"
        return 1
    fi

    while read -r LINE
    do
        LINE="${LINE%%#*}"
        KEY="${LINE%%:*}"
        VALUE="${LINE#${KEY}:}"

        if [ "$KEY" = "base_url" ] && [ -n "$VALUE" ]
        then
            BASE_URL="$VALUE"
            break
        fi
    done < "$GENERATOR_DIR/$INPUT"

    if [ -z "$BASE_URL" ]
    then
        error "No base_url found in file \"$INPUT\""
        return 1
    fi

    while IFS=":" read -r PKG VERSION COMPRESSION
    do
        if ! [ -f "${SOURCE_LOCATION}/$PKG-$VERSION.tar.$COMPRESSION" ]
        then
            wget \
                --https-only \
                -P "${SOURCE_LOCATION}" \
                "$BASE_URL/$PKG-$VERSION.tar.$COMPRESSION" \
                || return 1
        fi
    done < "$GENERATOR_DIR/$PKG_VERSIONS"
}

for OPT in "$@"
do
    case "$OPT" in
    "-r" | "--retrieve-versions")
        retrieve_versions "$@"
        exit
        ;;

    "-g" | "--generate")
        generate_build_system "$@"
        exit
        ;;

    "-c" | "--clean")
        clean_build_system "$@"
        exit
        ;;

    "-d" | "--download")
        download_source_packages "$@"
        exit
        ;;

    *)
        ;;
    esac
done

error "No operation specified"
exit 1
