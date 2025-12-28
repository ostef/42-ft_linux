#!/bin/sh

pushd $LFS/sources

rm -rf glibc-2.29
tar -xf glibc-2.29.tar.xz
cd glibc-2.29

mkdir -v build
cd build

../configure \
    --prefix=/tools \
    --host=$LFS_TGT \
    --build=$(../scripts/config.guess) \
    --enable-kernel=3.2 \
    --with-headers=/tools/include

make
make install

popd
