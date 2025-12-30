#!/bin/sh

echo "Building Libtasn"

pushd /sources/additional

rm -rf libtasn1-4.13
tar -xf libtasn1-4.13.tar.gz
cd libtasn1-4.13

./configure --prefix=/usr --disable-static || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make install || exit 1
make -C doc/reference install-data-local

cd ..
rm -rf libtasn1-4.13

popd
