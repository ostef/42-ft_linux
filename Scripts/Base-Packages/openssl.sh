#!/bin/bash

echo "Building OpenSSL"

pushd /sources

rm -rf openssl-1.1.1a
tar -xf openssl-1.1.1a.tar.gz
cd openssl-1.1.1a

./config --prefix=/usr    \
    --openssldir=/etc/ssl \
    --libdir=lib          \
    shared                \
    zlib-dynamic || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS test

sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make -j$MAKE_JOBS MANSUFFIX=ssl install

mv -v /usr/share/doc/openssl /usr/share/doc/openssl-1.1.1a
cp -vfr doc/* /usr/share/doc/openssl-1.1.1a

cd ..
rm -rf openssl-1.1.1a

popd
