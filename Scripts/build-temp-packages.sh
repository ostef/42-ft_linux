#!/bin/bash

# Build temporary system tools

if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Do not run as root!"
    exit 1
fi

if [ "$(echo $MAKE_JOBS)" = "" ]; then
	echo "ERROR: \$MAKE_JOBS is not set"
	exit 1
fi

# Total build time is 42.7 SBU

start_ns=$(date +%s.%N)

Scripts/Temp-Packages/binutils-pass1.sh    || exit 1

end_ns=$(date +%s.%N)

elapsed=$(echo "$end_ns - $start_ns" | bc)
approximate_build_time=$(echo "$elapsed * 42.7" | bc -l)

printf "\n======== Building Binutils - pass 1 took 1 SBU = %s seconds ========\n" "$elapsed"
printf "======== Approximate expected build time: 42.7 SBU = %s ========\n\n" "$approximate_build_time"
sleep 6

Scripts/Temp-Packages/gcc-pass1.sh         || exit 1
Scripts/Temp-Packages/linux-api-headers.sh || exit 1
Scripts/Temp-Packages/glibc.sh             || exit 1
Scripts/Temp-Packages/libstdc++.sh         || exit 1
Scripts/Temp-Packages/binutils-pass2.sh    || exit 1
Scripts/Temp-Packages/gcc-pass2.sh         || exit 1
Scripts/Temp-Packages/tcl.sh               || exit 1
Scripts/Temp-Packages/expect.sh            || exit 1
Scripts/Temp-Packages/dejagnu.sh           || exit 1
Scripts/Temp-Packages/m4.sh                || exit 1
Scripts/Temp-Packages/ncurses.sh           || exit 1
Scripts/Temp-Packages/bash.sh              || exit 1
Scripts/Temp-Packages/bison.sh             || exit 1
Scripts/Temp-Packages/bzip2.sh             || exit 1
Scripts/Temp-Packages/coreutils.sh         || exit 1
Scripts/Temp-Packages/diffutils.sh         || exit 1
Scripts/Temp-Packages/file.sh              || exit 1
Scripts/Temp-Packages/findutils.sh         || exit 1
Scripts/Temp-Packages/gawk.sh              || exit 1
Scripts/Temp-Packages/gettext.sh           || exit 1
Scripts/Temp-Packages/grep.sh              || exit 1
Scripts/Temp-Packages/gzip.sh              || exit 1
Scripts/Temp-Packages/make.sh              || exit 1
Scripts/Temp-Packages/patch.sh             || exit 1
Scripts/Temp-Packages/perl.sh              || exit 1
Scripts/Temp-Packages/python.sh            || exit 1
Scripts/Temp-Packages/sed.sh               || exit 1
Scripts/Temp-Packages/tar.sh               || exit 1
Scripts/Temp-Packages/texinfo.sh           || exit 1
Scripts/Temp-Packages/xz.sh                || exit 1

sudo -E chown -R root:root $LFS/tools
