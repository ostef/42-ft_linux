#!/bin/bash

echo "Building Diffutils"

pushd /sources

rm -rf diffutils-3.7
tar -xf diffutils-3.7.tar.xz
cd diffutils-3.7

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf diffutils-3.7

popd
