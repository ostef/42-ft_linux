#!/bin/sh

Scripts/Build/linux-api-headers.sh || exit 1
Scripts/Build/man-pages.sh         || exit 1
Scripts/Build/glibc.sh             || exit 1

Scripts/ajust-toolchain.sh || exit 1

Scripts/Build/zlib.sh     || exit 1
Scripts/Build/file.sh     || exit 1
Scripts/Build/readline.sh || exit 1
Scripts/Build/m4.sh       || exit 1
Scripts/Build/bc.sh       || exit 1
Scripts/Build/binutils.sh || exit 1
Scripts/Build/gmp.sh      || exit 1
Scripts/Build/mpfr.sh     || exit 1
Scripts/Build/mpc.sh      || exit 1
Scripts/Build/shadow.sh   || exit 1

echo "===== Shadow has been installed, choose a password for root ====="
passwd root

Scripts/Build/gcc.sh        || exit 1
Scripts/Build/bzip2.sh      || exit 1
Scripts/Build/pkg-config.sh || exit 1
Scripts/Build/ncurses.sh    || exit 1
Scripts/Build/attr.sh       || exit 1
Scripts/Build/acl.sh        || exit 1
Scripts/Build/libcap.sh     || exit 1
Scripts/Build/sed.sh        || exit 1
Scripts/Build/psmisc.sh     || exit 1
Scripts/Build/iana-etc.sh   || exit 1
Scripts/Build/bison.sh      || exit 1
Scripts/Build/flex.sh       || exit 1
Scripts/Build/grep.sh       || exit 1
Scripts/Build/bash.sh       || exit 1

# At this point, we could use the newly built bash (and in the LFS book this is what they do)
# but this means we need to make a break in the build process, which I don't like
# I think it's fine to use /tools/bash

Scripts/Build/libtool.sh    || exit 1
Scripts/Build/gdbm.sh       || exit 1
Scripts/Build/gperf.sh      || exit 1
Scripts/Build/expat.sh      || exit 1
Scripts/Build/inetutils.sh  || exit 1
Scripts/Build/perl.sh       || exit 1
Scripts/Build/xml-parser.sh || exit 1
Scripts/Build/intltool.sh   || exit 1
Scripts/Build/autoconf.sh   || exit 1
Scripts/Build/automake.sh   || exit 1
Scripts/Build/xz.sh         || exit 1
Scripts/Build/kmod.sh       || exit 1
Scripts/Build/gettext.sh    || exit 1
Scripts/Build/libelf.sh     || exit 1
Scripts/Build/libffi.sh     || exit 1
Scripts/Build/openssl.sh    || exit 1
Scripts/Build/python.sh     || exit 1
Scripts/Build/ninja.sh      || exit 1
Scripts/Build/meson.sh      || exit 1
Scripts/Build/coreutils.sh  || exit 1

