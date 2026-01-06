#!/bin/bash

echo "Building Acl"

pushd /sources

rm -rf acl-2.2.53
tar -xf acl-2.2.53.tar.gz
cd acl-2.2.53

./configure --prefix=/usr \
    --bindir=/bin         \
    --disable-static      \
    --libexecdir=/usr/lib \
    --docdir=/usr/share/doc/acl-2.2.53 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

mv -v /usr/lib/libacl.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so

cd ..
rm -rf acl-2.2.53

popd
