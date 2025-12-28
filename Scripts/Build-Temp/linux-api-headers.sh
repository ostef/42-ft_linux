#!/bin/sh

pushd $LFS/sources

rm -rf linux-4.20.12
tar -xf linux-4.20.12.tar.xz
cd linux-4.20.12

make mrproper
make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include

popd
