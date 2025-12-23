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