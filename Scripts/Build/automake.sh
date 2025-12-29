#!/bin/sh

echo "Building Automake"

pushd /sources

rm -rf automake-1.16.1
tar -xf automake-1.16.1.tar.xz
cd automake-1.16.1

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.1 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf automake-1.16.1

popd
