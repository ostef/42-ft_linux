#!/bin/bash

pushd /sources

rm -rf lfs-bootscripts-20180820
tar -xf lfs-bootscripts-20180820.tar.bz2
cd lfs-bootscripts-20180820

make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf lfs-bootscripts-20180820

popd
