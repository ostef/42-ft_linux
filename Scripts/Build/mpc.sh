#!/bin/sh

echo "Building MPC"

pushd /sources

rm -rf mpc-1.1.0
tar -xf mpc-1.1.0.tar.gz
cd mpc-1.1.0

./configure --prefix=/usr \
    --disable-static      \
    --docdir=/usr/share/doc/mpc-1.1.0 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS html

make -j$MAKE_JOBS check

make -j$MAKE_JOBS install || exit 1
make -j$MAKE_JOBS install-html

cd ..
rm -rf mpc-1.1.0

popd
