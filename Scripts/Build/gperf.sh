#!/bin/sh

echo "Building Gperf"

pushd /sources

rm -rf gperf-3.1
tar -xf gperf-3.1.tar.gz
cd gperf-3.1

./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1 || exit 1

make -j$MAKE_JOBS || exit 1
make check # Failures can happen when running in parallel
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf gperf-3.1

popd
