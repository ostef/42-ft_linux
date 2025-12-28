#!/bin/sh

echo "Building Make"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf make-4.2.1
tar -xf make-4.2.1.tar.bz2
cd make-4.2.1

sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c

./configure --prefix=/tools --without-guile

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf make-4.2.1

popd
