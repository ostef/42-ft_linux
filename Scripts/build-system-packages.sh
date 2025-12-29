#!/bin/sh

Scripts/Build/linux-api-headers.sh || exit 1
Scripts/Build/man-pages.sh         || exit 1
Scripts/Build/glibc.sh             || exit 1

Scripts/ajust-toolchain.sh || exit 1

Scripts/Build/zlib.sh             || exit 1
Scripts/Build/file.sh             || exit 1
