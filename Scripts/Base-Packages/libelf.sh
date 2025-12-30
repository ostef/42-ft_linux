#!/bin/sh

echo "Building Libelf from Elfutils"

pushd /sources

rm -rf elfutils-0.176
tar -xf elfutils-0.176.tar.bz2
cd elfutils-0.176

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS -C libelf install || exit 1

install -vm644 config/libelf.pc /usr/lib/pkgconfig

cd ..
rm -rf elfutils-0.176

popd
