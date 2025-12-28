#!/bin/sh

echo "Building Python"

if [ "$EUID" -eq 0 ]
then
    echo "Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf Python-3.7.2
tar -xf Python-3.7.2.tar.xz
cd Python-3.7.2

sed -i "/def add_multiarch_paths/a\        return" setup.py

./configure --prefix=/tools --without-ensurepip

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf Python-3.7.2

popd
