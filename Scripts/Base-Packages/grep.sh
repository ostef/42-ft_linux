#!/bin/sh

echo "Building Grep"

pushd /sources

rm -rf grep-3.3
tar -xf grep-3.3.tar.xz
cd grep-3.3

./configure --prefix=/usr --bindir=/bin || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS -k check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf grep-3.3

popd
