# No shebang here since bash might be in a different location. Running this
# script with bash is the executer's obligation.

set -e
[ $UID -eq 0 ] || { echo "This script must be executed as root"; exit 1; }

cd /tmp
rm -rf dummy_src_pkg
install -dm755 dummy_src_pkg/usr
tar -czf ${SOURCE_LOCATION}/dummy_src_pkg.tar.gz dummy_src_pkg

rm -rf dummy_src_pkg

# Do not cause enything to rebuild upon recreation of the dummy package.
# The dummy package will never change since it is empty. However if it changes,
# this is considered a fundamental change to the build system hence manually
# fixing things is ok.
touch -d "1970-1-1 utc" "${SOURCE_LOCATION}/dummy_src_pkg.tar.gz"

exit 0
