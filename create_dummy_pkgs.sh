set -e
set -x

[ $UID -eq 0 ]

cd /tmp

rm -rf dummy_pkgs

mkdir dummy_pkgs
cd dummy_pkgs

# Create the packages
declare -a PKGS
for PKG in \
    libstdc++-${libstdcxx_ABI} \
    libgcc-${libgcc_ABI} \
    libblkid-${libblkid_ABI}
do
    tpm --create-desc sw
    tpm --set-name $PKG
    tpm --set-version 0.0.0
    tpm --set-arch ${PKG_ARCH}

    install -dm755 destdir/usr
    tpm --add-files
    tpm --pack

    cp *.tpm.tar ${COLLECTING_DIR}/
    rm -rf *
done

cd ..
rm -rf dummy_pkgs
