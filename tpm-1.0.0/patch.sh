# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

set -e

# Verify that the script is executed as root user (import for creating files
# since the owner does not have to be then)
[ $UID -eq 0 ]

# Temporary work around the bogous Makefile of tpm (shame on me)
patch -bp0 < ${PACKAGING_RESOURCE_DIR}/bogous_Makefile.patch