#!/bin/sh

echo "Building Autoconf"

pushd /sources

rm -rf autoconf-2.69
tar -xf autoconf-2.69.tar.xz
cd autoconf-2.69

sed '361 s/{/\\{/' -i bin/autoscan.in

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
# make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf autoconf-2.69

popd
