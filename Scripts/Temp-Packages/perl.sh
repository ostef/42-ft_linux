#!/bin/bash

echo "Building Perl"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf perl-5.28.1
tar -xf perl-5.28.1.tar.xz
cd perl-5.28.1

sh Configure -des -Dprefix=/tools -Dlibs=-lm -Uloclibpth -Ulocincpth

make -j$MAKE_JOBS || exit 1

cp -v perl cpan/podlators/scripts/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/5.28.1
cp -Rv lib/* /tools/lib/perl5/5.28.1

cd ..
rm -rf perl-5.28.1

popd
