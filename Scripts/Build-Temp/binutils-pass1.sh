#!/bin/sh

pushd $LFS/sources

rm -rf binutils-2.32
tar -xf binutils-2.32.tar.xz
cd binutils-2.32

mkdir -v build
cd build

../configure --prefix=/tools \
    --with-sysroot=$LFS \
    --with-lib-path=/tools/lib \
    --target=$LFS_TGT \
    --disable-nls \
    --disable-werror

make
make install

popd
