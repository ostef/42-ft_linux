#!/bin/sh

echo "Building Texinfo"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf texinfo-6.5
tar -xf texinfo-6.5.tar.xz
cd texinfo-6.5

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf texinfo-6.5

popd
