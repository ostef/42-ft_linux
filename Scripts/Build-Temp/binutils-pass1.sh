#!/bin/sh

echo "Building Binutils - Pass 1"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

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
    --disable-werror || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ../..
rm -rf binutils-2.32

popd
