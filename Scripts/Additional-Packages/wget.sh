#!/bin/sh

echo "Building Wget"

pushd /sources/additional

rm -rf wget-1.21.1
tar -xf wget-1.21.1.tar.gz
cd wget-1.21.1

./configure --prefix=/usr --with-ssl=openssl || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf wget-1.21.1

popd
