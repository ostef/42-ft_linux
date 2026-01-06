#!/bin/bash

echo "Building Tar"

pushd /sources

rm -rf tar-1.31
tar -xf tar-1.31.tar.xz
cd tar-1.31

sed -i 's/abort.*/FALLTHROUGH;/' src/extract.c

FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/usr --bindir=/bin || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1
make -C doc install-html docdir=/usr/share/doc/tar-1.31

cd ..
rm -rf tar-1.31

popd
