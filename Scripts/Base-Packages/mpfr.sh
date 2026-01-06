#!/bin/bash

echo "Building MPFR"

pushd /sources

rm -rf mpfr-4.0.2
tar -xf mpfr-4.0.2.tar.xz
cd mpfr-4.0.2

./configure --prefix=/usr \
    --disable-static      \
    --enable-thread-safe  \
    --docdir=/usr/share/doc/mpfr-4.0.2 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS html

make -j$MAKE_JOBS check

make -j$MAKE_JOBS install || exit 1
make -j$MAKE_JOBS install-html

cd ..
rm -rf mpfr-4.0.2

popd
