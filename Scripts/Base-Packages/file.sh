#!/bin/bash

echo "Building File"

pushd /sources

rm -rf file-5.36
tar -xf file-5.36.tar.gz
cd file-5.36

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf file-5.36

popd
