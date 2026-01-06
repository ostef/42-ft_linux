#!/bin/bash

echo "Building GMP"

pushd /sources

rm -rf gmp-6.1.2
tar -xf gmp-6.1.2.tar.xz
cd gmp-6.1.2

# Compile for a more generic architecture to avoid any problem
cp -v configfsf.guess config.guess
cp -v configfsf.sub   config.sub

./configure --prefix=/usr \
    --enable-cxx          \
    --disable-static      \
    --docdir=/usr/share/doc/gmp-6.1.2 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS html

make -j$MAKE_JOBS check 2>&1 | tee gmp-check-log

# Show test results
awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log
sleep 4

make -j$MAKE_JOBS install || exit 1
make -j$MAKE_JOBS install-html

cd ..
rm -rf gmp-6.1.2

popd
