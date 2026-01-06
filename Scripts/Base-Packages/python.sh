#!/bin/bash

echo "Building Python"

pushd /sources

rm -rf Python-3.7.2
tar -xf Python-3.7.2.tar.xz
cd Python-3.7.2

./configure --prefix=/usr \
    --enable-shared       \
    --with-system-expat   \
    --with-system-ffi     \
    --with-ensurepip=yes

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install

chmod -v 755 /usr/lib/libpython3.7m.so
chmod -v 755 /usr/lib/libpython3.so

install -v -dm755 /usr/share/doc/python-3.7.2/html
tar --strip-components=1                \
    --no-same-owner                     \
    --no-same-permissions               \
    -C /usr/share/doc/python-3.7.2/html \
    -xvf ../python-3.7.2-docs-html.tar.bz2

cd ..
rm -rf Python-3.7.2

popd
