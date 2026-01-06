#!/bin/bash

echo "Building Xz"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf xz-5.2.4
tar -xf xz-5.2.4.tar.xz
cd xz-5.2.4

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf xz-5.2.4

popd
