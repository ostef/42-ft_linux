#!/bin/sh

echo "Building Ncurses"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf ncurses-6.1
tar -xf ncurses-6.1.tar.gz
cd ncurses-6.1

sed -i s/mawk// configure

./configure --prefix=/tools \
    --with-shared           \
    --without-debug         \
    --without-ada           \
    --enable-widec          \
    --enable-overwrite

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

ln -s libncursesw.so /tools/lib/libncurses.so

cd ..
rm -rf ncurses-6.1

popd
