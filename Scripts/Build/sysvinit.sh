#!/bin/sh

echo "Building Sysvinit"

pushd /sources

rm -rf sysvinit-2.93
tar -xf sysvinit-2.93.tar.xz
cd sysvinit-2.93

patch -Np1 -i ../sysvinit-2.93-consolidated-1.patch

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf sysvinit-2.93

popd
