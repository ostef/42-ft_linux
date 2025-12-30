#!/bin/sh

echo "Building Bison"

pushd /sources

rm -rf bison-3.3.2
tar -xf bison-3.3.2.tar.xz
cd bison-3.3.2

./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.3.2 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf bison-3.3.2

popd
