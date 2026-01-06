#!/bin/bash

echo "Building Tar"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf tar-1.31
tar -xf tar-1.31.tar.xz
cd tar-1.31

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf tar-1.31

popd
