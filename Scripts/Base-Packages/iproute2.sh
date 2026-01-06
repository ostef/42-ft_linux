#!/bin/bash

echo "Building IPRoute2"

pushd /sources

rm -rf iproute2-4.20.0
tar -xf iproute2-4.20.0.tar.xz
cd iproute2-4.20.0

sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

sed -i 's/.m_ipt.o//' tc/Makefile

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS DOCDIR=/usr/share/doc/iproute2-4.20.0 install || exit 1

cd ..
rm -rf iproute2-4.20.0

popd
