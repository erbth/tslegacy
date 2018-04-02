# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

# Compile for a general x86 CPU without specific optimization
cp -v configfsf.guess config.guess
cp -v configfsf.sub config.sub
