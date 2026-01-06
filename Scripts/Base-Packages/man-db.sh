#!/bin/bash

echo "Building Man-DB"

pushd /sources

rm -rf man-db-2.8.5
tar -xf man-db-2.8.5.tar.xz
cd man-db-2.8.5

./configure --prefix=/usr                \
    --docdir=/usr/share/doc/man-db-2.8.5 \
    --sysconfdir=/etc                    \
    --disable-setuid                     \
    --enable-cache-owner=bin             \
    --with-browser=/usr/bin/lynx         \
    --with-vgrind=/usr/bin/vgrind        \
    --with-grap=/usr/bin/grap            \
    --with-systemdtmpfilesdir=           \
    --with-systemdsystemunitdir= || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf man-db-2.8.5

popd
