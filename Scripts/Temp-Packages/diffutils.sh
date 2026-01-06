#!/bin/bash

echo "Building Diffutils"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf diffutils-3.7
tar -xf diffutils-3.7.tar.xz
cd diffutils-3.7

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf diffutils-3.7

popd
