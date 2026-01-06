#!/bin/bash

echo "Building Shadow"

pushd /sources

rm -rf shadow-4.6
tar -xf shadow-4.6.tar.xz
cd shadow-4.6

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
    -e 's@/var/spool/mail@/var/mail@' etc/login.defs

sed -i 's/1000/999/' etc/useradd

./configure --sysconfdir=/etc --with-group-name-max-length=32

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

mv -v /usr/bin/passwd /bin

# Configure shadow
pwconv
grpconv

cd ..
rm -rf shadow-4.6

popd
