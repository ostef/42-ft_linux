#!/bin/sh

echo "Building Gawk"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf gawk-4.2.1
tar -xf gawk-4.2.1.tar.xz
cd gawk-4.2.1

./configure --prefix=/tools

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf gawk-4.2.1

popd
