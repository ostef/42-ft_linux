#!/bin/bash

echo "Building Gawk"

pushd /sources

rm -rf gawk-4.2.1
tar -xf gawk-4.2.1.tar.xz
cd gawk-4.2.1

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

mkdir -v /usr/share/doc/gawk-4.2.1
cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.2.1

cd ..
rm -rf gawk-4.2.1

popd
