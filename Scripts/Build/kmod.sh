#!/bin/sh

echo "Building Kmod"

pushd /sources

rm -rf kmod-26
tar -xf kmod-26.tar.xz
cd kmod-26

./configure --prefix=/usr  \
    --bindir=/bin          \
    --sysconfdir=/etc      \
    --with-rootlibdir=/lib \
    --with-xz              \
    --with-zlib || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

for target in depmod insmod lsmod modinfo modprobe rmmod; do
    ln -sfv ../bin/kmod /sbin/$target
done
ln -sfv kmod /bin/lsmod

cd ..
rm -rf kmod-26

popd
