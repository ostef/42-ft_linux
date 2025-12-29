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
