#!/bin/sh

# Build temporary system tools

if [ "$EUID" -eq 0 ]
then
    echo "Do not run as root!"
    exit 1
fi

# Total build time is 42.7 SBU

start_ns=$(date +%s.%N)

Scripts/Build-Temp/binutils-pass1.sh    || exit 1

end_ns=$(date +%s.%N)

elapsed=$(echo "$end_ns - $start_ns" | bc)
approximate_build_time=$(echo "$elapsed * 42.7" | bc -l)

printf "Building Binutils - pass 1 took 1 SBU = %s seconds\n" "$elapsed"
printf "Approximate expected build time: 42.7 SBU = %s\n" "$approximate_build_time"
sleep 6

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
Scripts/Build-Temp/ncurses.sh           || exit 1
Scripts/Build-Temp/bash.sh              || exit 1
Scripts/Build-Temp/bison.sh             || exit 1
Scripts/Build-Temp/bzip2.sh             || exit 1
Scripts/Build-Temp/coreutils.sh         || exit 1
Scripts/Build-Temp/diffutils.sh         || exit 1
Scripts/Build-Temp/file.sh              || exit 1
Scripts/Build-Temp/findutils.sh         || exit 1
Scripts/Build-Temp/gawk.sh              || exit 1
Scripts/Build-Temp/gettext.sh           || exit 1
Scripts/Build-Temp/grep.sh              || exit 1
Scripts/Build-Temp/gzip.sh              || exit 1
Scripts/Build-Temp/make.sh              || exit 1
Scripts/Build-Temp/patch.sh             || exit 1
Scripts/Build-Temp/perl.sh              || exit 1
Scripts/Build-Temp/python.sh            || exit 1
Scripts/Build-Temp/sed.sh               || exit 1
Scripts/Build-Temp/tar.sh               || exit 1
Scripts/Build-Temp/texinfo.sh           || exit 1
Scripts/Build-Temp/xz.sh                || exit 1

sudo -E chown -R root:root $LFS/tools
