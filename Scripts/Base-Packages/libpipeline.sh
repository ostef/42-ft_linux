#!/bin/sh

echo "Building Libpipeline"

pushd /sources

rm -rf libpipeline-1.5.1
tar -xf libpipeline-1.5.1.tar.gz
cd libpipeline-1.5.1

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf libpipeline-1.5.1

popd
