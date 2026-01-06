#!/bin/bash

echo "Building Gettext"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf gettext-0.19.8.1
tar -xf gettext-0.19.8.1.tar.xz
cd gettext-0.19.8.1

cd gettext-tools

EMACS="no" ./configure --prefix=/tools --disable-shared

make -j$MAKE_JOBS -C gnulib-lib || exit 1
make -j$MAKE_JOBS -C intl pluralx.c || exit 1
make -j$MAKE_JOBS -C src msgfmt || exit 1
make -j$MAKE_JOBS -C src msgmerge || exit 1
make -j$MAKE_JOBS -C src xgettext || exit 1

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

cd ..
rm -rf gettext-0.19.8.1

popd
