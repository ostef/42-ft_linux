#!/bin/sh

echo "Building Zlib"

pushd /sources

rm -rf zlib-1.2.11
tar -xf zlib-1.2.11.tar.xz
cd zlib-1.2.11

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

cd ..
rm -rf zlib-1.2.11

popd
