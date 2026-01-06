#!/bin/bash

echo "Building Psmisc"

pushd /sources

rm -rf psmisc-23.2
tar -xf psmisc-23.2.tar.xz
cd psmisc-23.2

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

mv -v /usr/bin/fuser   /bin
mv -v /usr/bin/killall /bin

cd ..
rm -rf psmisc-23.2

popd
