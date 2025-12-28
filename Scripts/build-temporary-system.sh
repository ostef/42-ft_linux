#!/bin/sh

# Build temporary system tools

if [ "$EUID" -eq 0 ]
then
    echo "Do not run as root!"
    exit 1
fi

Scripts/Build-Temp/binutils-pass1.sh || exit 1
Scripts/Build-Temp/gcc-pass1.sh || exit 1
Scripts/Build-Temp/linux-api-headers.sh || exit 1
Scripts/Build-Temp/glibc.sh || exit 1

# Sanity check
echo 'int main(){}' > dummy.c
/tools/bin/$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools' || exit 1
rm -f dummy.c a.out

Scripts/Build-Temp/libstdc++.sh || exit 1
