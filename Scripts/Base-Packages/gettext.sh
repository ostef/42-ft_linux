#!/bin/bash

echo "Building Gettext"

pushd /sources

rm -rf gettext-0.19.8.1
tar -xf gettext-0.19.8.1.tar.xz
cd gettext-0.19.8.1

sed -i '/^TESTS =/d' gettext-runtime/tests/Makefile.in &&
sed -i 's/test-lock..EXEEXT.//' gettext-tools/gnulib-tests/Makefile.in

sed -e '/AppData/{N;N;p;s/\.appdata\./.metainfo./}' -i gettext-tools/its/appdata.loc

./configure --prefix=/usr \
    --disable-static      \
    --docdir=/usr/share/doc/gettext-0.19.8.1 || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

chmod -v 0755 /usr/lib/preloadable_libintl.so

cd ..
rm -rf gettext-0.19.8.1

popd
