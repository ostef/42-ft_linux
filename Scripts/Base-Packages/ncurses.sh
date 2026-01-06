#!/bin/bash

echo "Building Ncurses"

pushd /sources

rm -rf ncurses-6.1
tar -xf ncurses-6.1.tar.gz
cd ncurses-6.1

sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in

./configure --prefix=/usr   \
    --mandir=/usr/share/man \
    --with-shared           \
    --without-debug         \
    --without-normal        \
    --enable-pc-files       \
    --enable-widec || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

mv -v /usr/lib/libncursesw.so.6* /lib
# Fix broken symlink now that we've moved the file
ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so

mkdir -v       /usr/share/doc/ncurses-6.1
cp -v -R doc/* /usr/share/doc/ncurses-6.1

cd ..
rm -rf ncurses-6.1

popd
