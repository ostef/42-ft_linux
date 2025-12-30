#!/bin/sh

echo "Building Groff"

pushd /sources

rm -rf groff-1.22.4
tar -xf groff-1.22.4.tar.gz
cd groff-1.22.4

PAGE=A4 ./configure --prefix=/usr || exit 1

make || exit 1 # No parallel build
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf groff-1.22.4

popd
