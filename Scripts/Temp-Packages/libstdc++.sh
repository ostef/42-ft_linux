#!/bin/sh

echo "Building libstdc++"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf gcc-8.2.0
tar -xf gcc-8.2.0.tar.xz
cd gcc-8.2.0

mkdir -v build
cd build

../libstdc++-v3/configure       \
    --host=$LFS_TGT             \
    --prefix=/tools             \
    --disable-multilib          \
    --disable-nls               \
    --disable-libstdcxx-threads \
    --disable-libstdcxx-pch     \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/8.2.0 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ../..
rm -rf gcc-8.2.0

popd
