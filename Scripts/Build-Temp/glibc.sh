#!/bin/sh

echo "Building glibc"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf glibc-2.29
tar -xf glibc-2.29.tar.xz
cd glibc-2.29

mkdir -v build
cd build

../configure                           \
    --prefix=/tools                    \
    --host=$LFS_TGT                    \
    --build=$(../scripts/config.guess) \
    --enable-kernel=3.2                \
    --with-headers=/tools/include || exit 1

# Compilation can fail when building in parallel, do not add -j$MAKE_JOBS
make || exit 1
make install || exit 1

cd ../..
rm -rf glibc-2.29

popd
