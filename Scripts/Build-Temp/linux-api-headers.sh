#!/bin/sh

echo "Building Linux API headers"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf linux-4.20.12
tar -xf linux-4.20.12.tar.xz
cd linux-4.20.12

make mrproper
make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include

cd ..
rm -rf linux-4.20.12

popd
