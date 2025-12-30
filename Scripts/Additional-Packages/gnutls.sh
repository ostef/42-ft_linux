#!/bin/sh

echo "Building GNUTLS"

pushd /sources/additional

rm -rf gnutls-3.6.6
tar -xf gnutls-3.6.6.tar.xz
cd gnutls-3.6.6

./configure --prefix=/usr --disable-guile --with-default-trust-store-pkcs11="pkcs11:" --with-included-unistring || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1
make -j$MAKE_JOBS -C doc/reference install-data-local

cd ..
rm -rf gnutls-3.6.6

popd
