#!/bin/bash

echo "Building Bzip2"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf bzip2-1.0.6
tar -xf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS PREFIX=/tools install || exit 1

cd ..
rm -rf bzip2-1.0.6

popd
