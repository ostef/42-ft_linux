#!/bin/sh

echo "Building XML::Parser"

pushd /sources

rm -rf XML-Parser-2.44
tar -xf XML-Parser-2.44.tar.gz
cd XML-Parser-2.44

perl Makefile.PL

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS test
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf XML-Parser-2.44

popd
