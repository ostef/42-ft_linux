#!/bin/sh

echo "Building Expat"

pushd /sources

rm -rf expat-2.2.6
tar -xf expat-2.2.6.tar.bz2
cd expat-2.2.6

sed -i 's|usr/bin/env |bin/|' run.sh.in

./configure --prefix=/usr --disable-static --docdir=/usr/share/doc/expat-2.2.6 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.2.6

cd ..
rm -rf expat-2.2.6

popd
