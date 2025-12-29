#!/bin/sh

Scripts/Build/linux-api-headers.sh || exit 1
Scripts/Build/man-pages.sh         || exit 1
Scripts/Build/glibc.sh             || exit 1

Scripts/ajust-toolchain.sh || exit 1

Scripts/Build/zlib.sh             || exit 1
Scripts/Build/file.sh             || exit 1
Scripts/Build/readline.sh         || exit 1
Scripts/Build/m4.sh               || exit 1
Scripts/Build/bc.sh               || exit 1
Scripts/Build/binutils.sh         || exit 1
Scripts/Build/gmp.sh              || exit 1
Scripts/Build/mpfr.sh             || exit 1
Scripts/Build/mpc.sh              || exit 1
Scripts/Build/shadow.sh           || exit 1

echo "===== Shadow has been installed, choose a password for root ====="
passwd root
