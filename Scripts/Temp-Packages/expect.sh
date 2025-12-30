#!/bin/sh

echo "Building Expect"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf expect5.45.4
tar -xf expect5.45.4.tar.gz
cd expect5.45.4

cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure --prefix=/tools \
    --with-tcl=/tools/lib   \
    --with-tclinclude=/tools/include || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS SCRIPTS="" install || exit 1

cd ..
rm -rf expect5.45.4

popd
