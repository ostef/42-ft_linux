#!/bin/bash

echo "Building Pkg-config"

pushd /sources

rm -rf pkg-config-0.29.2
tar -xf pkg-config-0.29.2.tar.gz
cd pkg-config-0.29.2

./configure --prefix=/usr \
    --with-internal-glib  \
    --disable-host-tool   \
    --docdir=/usr/share/doc/pkg-config-0.29.2 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf pkg-config-0.29.2

popd
