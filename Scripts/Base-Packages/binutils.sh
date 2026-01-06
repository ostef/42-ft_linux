#!/bin/bash

echo "Building Binutils"

pushd /sources

rm -rf binutils-2.32
tar -xf binutils-2.32.tar.xz
cd binutils-2.32

mkdir -v build
cd build

../configure --prefix=/usr \
    --enable-gold          \
    --enable-ld=default    \
    --enable-plugins       \
    --enable-shared        \
    --disable-werror       \
    --enable-64-bit-bfd    \
    --with-system-zlib

make -j$MAKE_JOBS tooldir=/usr || exit 1
make -j$MAKE_JOBS -k check || exit 1
make -j$MAKE_JOBS tooldir=/usr install || exit 1

cd ../..
rm -rf binutils-2.32

popd
