#!/bin/sh

echo "Building Patch"

pushd /sources

rm -rf patch-2.7.6
tar -xf patch-2.7.6.tar.xz
cd patch-2.7.6

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf patch-2.7.6

popd
