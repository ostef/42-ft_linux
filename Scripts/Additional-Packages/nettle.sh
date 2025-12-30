#!/bin/sh

echo "Building Nettle"

pushd /sources/additional

rm -rf nettle-3.4.1
tar -xf nettle-3.4.1.tar.gz
cd nettle-3.4.1

./configure --prefix=/usr --disable-static || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

chmod   -v   755 /usr/lib/lib{hogweed,nettle}.so &&
install -v -m755 -d /usr/share/doc/nettle-3.4.1 &&
install -v -m644 nettle.html /usr/share/doc/nettle-3.4.1

cd ..
rm -rf nettle-3.4.1

popd
