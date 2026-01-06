#!/bin/bash

echo "Building Libcap"

pushd /sources

rm -rf libcap-2.26
tar -xf libcap-2.26.tar.xz
cd libcap-2.26

sed -i '/install.*STALIBNAME/d' libcap/Makefile

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS RAISE_SETFCAP=no lib=lib prefix=/usr install || exit 1
chmod -v 755 /usr/lib/libcap.so.2.26

mv -v /usr/lib/libcap.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so

cd ..
rm -rf libcap-2.26

popd
