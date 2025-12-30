#!/bin/sh

echo "Building Sed"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf sed-4.7
tar -xf sed-4.7.tar.xz
cd sed-4.7

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf sed-4.7

popd
