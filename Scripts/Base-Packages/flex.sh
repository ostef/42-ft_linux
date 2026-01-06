#!/bin/bash

echo "Building Flex"

pushd /sources

rm -rf flex-2.6.4
tar -xf flex-2.6.4.tar.gz
cd flex-2.6.4

sed -i "/math.h/a #include <malloc.h>" src/flexdef.h

HELP2MAN=/tools/bin/true \
./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.6.4 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

ln -sv flex /usr/bin/lex

cd ..
rm -rf flex-2.6.4

popd
