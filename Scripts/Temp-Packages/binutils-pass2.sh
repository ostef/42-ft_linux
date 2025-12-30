#!/bin/sh

echo "Building Binutils - Pass 2"

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

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../configure                   \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin

cd ../..
rm -rf binutils-2.32

popd
