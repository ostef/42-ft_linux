#!/bin/sh

echo "Building File"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf file-5.36
tar -xf file-5.36.tar.gz
cd file-5.36

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf file-5.36

popd
