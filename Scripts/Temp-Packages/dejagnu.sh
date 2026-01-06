#!/bin/bash

echo "Building DejaGNU"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf dejagnu-1.6.2
tar -xf dejagnu-1.6.2.tar.gz
cd dejagnu-1.6.2

./configure --prefix=/tools

make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf dejagnu-1.6.2

popd
