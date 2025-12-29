#!/bin/sh

echo "Building GDBM"

pushd /sources

rm -rf gdbm-1.18.1
tar -xf gdbm-1.18.1.tar.gz
cd gdbm-1.18.1

./configure --prefix=/usr --disable-static --enable-libgdbm-compat || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf gdbm-1.18.1

popd
