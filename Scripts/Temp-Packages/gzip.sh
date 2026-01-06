#!/bin/bash

echo "Building GZip"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf gzip-1.10
tar -xf gzip-1.10.tar.xz
cd gzip-1.10

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf gzip-1.10

popd
