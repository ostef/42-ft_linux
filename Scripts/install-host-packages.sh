#!/bin/sh

# Packages to install on a fresh Debian 13 install
# More packages might need to be installed on other
# systems (use version-check.sh)

apt update
apt install bison -y
apt install gawk -y
apt install texinfo -y # For makeinfo

rm -f /bin/sh
ln -s bash /bin/sh

# Newer versions of make cause problems when compiling glibc, so we downgrade
pushd ~/Downloads

wget https://ftp.gnu.org/gnu/make/make-4.3.tar.gz
tar -xf make-4.3.tar.gz
cd make-4.3

./configure || exit 1
make || exit 1
make install || exit 1
cd ..

rm -rf make-4.3

popd
