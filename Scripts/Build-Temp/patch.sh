#!/bin/sh

echo "Building Patch"

if [ "$EUID" -eq 0 ]
then
    echo "Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf patch-2.7.6
tar -xf patch-2.7.6.tar.xz
cd patch-2.7.6

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf patch-2.7.6

popd
