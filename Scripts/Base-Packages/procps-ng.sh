#!/bin/bash

echo "Building Procps-ng"

pushd /sources

rm -rf procps-ng-3.3.15
tar -xf procps-ng-3.3.15.tar.xz
cd procps-ng-3.3.15

./configure --prefix=/usr                  \
  --exec-prefix=                           \
  --libdir=/usr/lib                        \
  --docdir=/usr/share/doc/procps-ng-3.3.15 \
  --disable-static                         \
  --disable-kill

make -j$MAKE_JOBS || exit 1

sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
sed -i '/set tty/d' testsuite/pkill.test/pkill.exp
rm testsuite/pgrep.test/pgrep.exp
make -j$MAKE_JOBS check

make -j$MAKE_JOBS install

mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so

cd ..
rm -rf procps-ng-3.3.15

popd
