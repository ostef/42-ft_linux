#!/bin/bash

echo "Building Make"

pushd /sources

rm -rf make-4.2.1
tar -xf make-4.2.1.tar.bz2
cd make-4.2.1

sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS PERL5LIB=$PWD/tests/ check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf make-4.2.1

popd
