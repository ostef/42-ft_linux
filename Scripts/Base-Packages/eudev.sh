#!/bin/bash

echo "Building Eudev"

pushd /sources

rm -rf eudev-3.2.7
tar -xf eudev-3.2.7.tar.gz
cd eudev-3.2.7

cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF

./configure --prefix=/usr  \
    --bindir=/sbin         \
    --sbindir=/sbin        \
    --libdir=/usr/lib      \
    --sysconfdir=/etc      \
    --libexecdir=/lib      \
    --with-rootprefix=     \
    --with-rootlibdir=/lib \
    --enable-manpages      \
    --disable-static       \
    --config-cache

LIBRARY_PATH=/tools/lib make -j$MAKE_JOBS || exit 1

mkdir -pv /lib/udev/rules.d
mkdir -pv /etc/udev/rules.d

make -j$MAKE_JOBS LD_LIBRARY_PATH=/tools/lib check
make -j$MAKE_JOBS LD_LIBRARY_PATH=/tools/lib install || exit 1

# Install some custom rules and support files useful in an LFS environment
tar -xvf ../udev-lfs-20171102.tar.bz2
make -j$MAKE_JOBS -f udev-lfs-20171102/Makefile.lfs install

# Configure
LD_LIBRARY_PATH=/tools/lib udevadm hwdb --update

cd ..
rm -rf eudev-3.2.7

popd
