#!/bin/bash

echo "Building Attr"

pushd /sources

rm -rf attr-2.4.48
tar -xf attr-2.4.48.tar.gz
cd attr-2.4.48

./configure --prefix=/usr \
    --bindir=/bin         \
    --disable-static      \
    --sysconfdir=/etc     \
    --docdir=/usr/share/doc/attr-2.4.48 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

mv -v /usr/lib/libattr.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so

cd ..
rm -rf attr-2.4.48

popd
