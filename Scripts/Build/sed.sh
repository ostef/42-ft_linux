#!/bin/sh

echo "Building Sed"

pushd /sources

rm -rf sed-4.7
tar -xf sed-4.7.tar.xz
cd sed-4.7

sed -i 's/usr/tools/' build-aux/help2man
sed -i 's/testsuite.panic-tests.sh//' Makefile.in

./configure --prefix=/usr --bindir=/bin || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS html
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

install -d -m755           /usr/share/doc/sed-4.7
install -m644 doc/sed.html /usr/share/doc/sed-4.7

cd ..
rm -rf sed-4.7

popd
