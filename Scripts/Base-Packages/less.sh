#!/bin/bash

echo "Building Less"

pushd /sources

rm -rf less-530
tar -xf less-530.tar.gz
cd less-530

./configure --prefix=/usr --sysconfdir=/etc || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf less-530

popd
