#!/bin/bash

echo "Building Coreutils"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf coreutils-8.30
tar -xf coreutils-8.30.tar.xz
cd coreutils-8.30

./configure --prefix=/tools --enable-install-program=hostname

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf coreutils-8.30

popd
