#!/bin/sh

echo "Building Bash"

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf bash-5.0
tar -xf bash-5.0.tar.gz
cd bash-5.0

./configure --prefix=/tools --without-bash-malloc

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

ln -sv bash /tools/bin/sh

cd ..
rm -rf bash-5.0

popd
