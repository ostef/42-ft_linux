#!/bin/sh

echo "Building Gzip"

pushd /sources

rm -rf gzip-1.10
tar -xf gzip-1.10.tar.xz
cd gzip-1.10

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

mv -v /usr/bin/gzip /bin

cd ..
rm -rf gzip-1.10

popd
