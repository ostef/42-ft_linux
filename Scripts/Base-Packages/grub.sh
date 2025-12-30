#!/bin/sh

echo "Building Grub"

pushd /sources

rm -rf grub-2.02
tar -xf grub-2.02.tar.xz
cd grub-2.02

./configure --prefix=/usr \
    --sbindir=/sbin       \
    --sysconfdir=/etc     \
    --disable-efiemu      \
    --disable-werror || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

cd ..
rm -rf grub-2.02

popd
