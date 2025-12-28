#!/bin/sh

# Build temporary system tools

# Build/binutils-pass1.sh || exit 1
Build/gcc-pass1.sh || exit 1
Build/linux-api-headers.sh || exit 1
Build/glibc.sh || exit 1

# Sanity check
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools'
rm dummy.c a.out
