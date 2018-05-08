# No shebang here since bash might be in a different location. Running this
# script with bash is the executer's obligation.

set -e
[ $UID -eq 0 ] || { echo "This script must be executed as root"; exit 1; }

cd /tmp
rm -rf dummy_src_pkg
install -dm755 dummy_src_pkg/usr
tar -czf ${SOURCE_LOCATION}/dummy_src_pkg.tar.gz dummy_src_pkg

rm -rf dummy_src_pkg
exit 0
