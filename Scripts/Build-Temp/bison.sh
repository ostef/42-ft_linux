#!/bin/sh

echo "Building Bison"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf bison-3.3.2
tar -xf bison-3.3.2.tar.xz
cd bison-3.3.2

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf bison-3.3.2

popd
