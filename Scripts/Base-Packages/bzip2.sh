#!/bin/sh

echo "Building Bzip2"

pushd /sources

rm -rf bzip2-1.0.6
tar -xf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6

patch -Np1 -i ../bzip2-1.0.6-install_docs-1.patch

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

make -j$MAKE_JOBS -f Makefile-libbz2_so || exit 1
make -j$MAKE_JOBS clean
make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS PREFIX=/usr install || exit 1

cp -v bzip2-shared /bin/bzip2
cp -av libbz2.so* /lib
ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
rm -v /usr/bin/{bunzip2,bzcat,bzip2}
ln -sv bzip2 /bin/bunzip2
ln -sv bzip2 /bin/bzcat

cd ..
rm -rf bzip2-1.0.6

popd
