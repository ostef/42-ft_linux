#!/bin/sh

echo "Building Grep"

if [ "$EUID" -eq 0 ]
then
    echo "Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf grep-3.3
tar -xf grep-3.3.tar.xz
cd grep-3.3

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf grep-3.3

popd
