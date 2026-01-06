#!/bin/bash

echo "Building Libtool"

pushd /sources

rm -rf libtool-2.4.6
tar -xf libtool-2.4.6.tar.xz
cd libtool-2.4.6

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make TESTSUITEFLAGS=-j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf libtool-2.4.6

popd
