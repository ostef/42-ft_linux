#!/bin/bash

echo "Building Iana-Etc"

pushd /sources

rm -rf iana-etc-2.30
tar -xf iana-etc-2.30.tar.bz2
cd iana-etc-2.30

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf iana-etc-2.30

popd
