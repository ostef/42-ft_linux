#!/bin/sh

echo "Building Readline"

pushd /sources

rm -rf readline-8.0
tar -xf readline-8.0.tar.gz
cd readline-8.0

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

./configure --prefix=/usr --disable-static --docdir=/usr/share/doc/readline-8.0 || exit 1

make -j$MAKE_JOBS SHLIB_LIBS="-L/tools/lib -lncursesw" || exit 1
make -j$MAKE_JOBS SHLIB_LIBS="-L/tools/lib -lncursesw" install || exit 1

mv -v /usr/lib/lib{readline,history}.so.* /lib
chmod -v u+w /lib/lib{readline,history}.so.*
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) /usr/lib/libhistory.so

# Install the documentation
install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.0

cd ..
rm -rf readline-8.0

popd
