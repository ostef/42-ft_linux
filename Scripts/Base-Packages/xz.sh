#!/bin/bash

echo "Building Xz"

pushd /sources

rm -rf xz-5.2.4
tar -xf xz-5.2.4.tar.xz
cd xz-5.2.4

./configure --prefix=/usr --disable-static --docdir=/usr/share/doc/xz-5.2.4 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

mv -v /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv -v /usr/lib/liblzma.so.* /lib
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so

cd ..
rm -rf xz-5.2.4

popd
