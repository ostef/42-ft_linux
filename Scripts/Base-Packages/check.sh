#!/bin/bash

echo "Building Check"

pushd /sources

rm -rf check-0.12.0
tar -xf check-0.12.0.tar.gz
cd check-0.12.0

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
# make -j$MAKE_JOBS check # Tests take 4 SBU so they are disabled by default
make -j$MAKE_JOBS install || exit 1

sed -i '1 s/tools/usr/' /usr/bin/checkmk

cd ..
rm -rf check-0.12.0

popd
