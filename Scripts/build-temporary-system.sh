#!/bin/sh

# Build temporary system tools

if [ "$EUID" -eq 0 ]
then
    echo "Do not run as root!"
    exit 1
fi

Scripts/Build-Temp/binutils-pass1.sh    || exit 1
Scripts/Build-Temp/gcc-pass1.sh         || exit 1
Scripts/Build-Temp/linux-api-headers.sh || exit 1
Scripts/Build-Temp/glibc.sh             || exit 1
Scripts/Build-Temp/libstdc++.sh         || exit 1
Scripts/Build-Temp/binutils-pass2.sh    || exit 1
Scripts/Build-Temp/gcc-pass2.sh         || exit 1
Scripts/Build-Temp/tcl.sh               || exit 1
Scripts/Build-Temp/expect.sh            || exit 1
Scripts/Build-Temp/dejagnu.sh           || exit 1
Scripts/Build-Temp/m4.sh                || exit 1
