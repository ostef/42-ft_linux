#!/bin/sh

echo "Building TCL"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf tcl8.6.9
tar -xf tcl8.6.9-src.tar.gz
cd tcl8.6.9

cd unix

./configure --prefix=/tools || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

# Make the installed library writable so we can remove debugging symbols later
chmod -v u+w /tools/lib/libtcl8.6.so

make install-private-headers

ln -sv tclsh8.6 /tools/bin/tclsh

cd ../..
rm -rf tcl8.6.9

popd
