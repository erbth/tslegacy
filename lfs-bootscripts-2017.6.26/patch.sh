# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

set -e

# Verify that the script is executed as root user (import for creating files
# since the owner does not have to be then)
[ $UID -eq 0 ]

# Disable periodic timestamp logging and the filesystemcheck which is normally
# performed on startup (since I do not have e2fsck ...)
sed -e 's/#\(SYSKLOGD_PARMS\)/\1/' \
    -e 's/#\(FASTBOOT\)/\1/' \
    -i lfs/sysconfig/rc.site
