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

Scripts/Build/libtool.sh     || exit 1
Scripts/Build/gdbm.sh        || exit 1
Scripts/Build/gperf.sh       || exit 1
Scripts/Build/expat.sh       || exit 1
Scripts/Build/inetutils.sh   || exit 1
Scripts/Build/perl.sh        || exit 1
Scripts/Build/xml-parser.sh  || exit 1
Scripts/Build/intltool.sh    || exit 1
Scripts/Build/autoconf.sh    || exit 1
Scripts/Build/automake.sh    || exit 1
Scripts/Build/xz.sh          || exit 1
Scripts/Build/kmod.sh        || exit 1
Scripts/Build/gettext.sh     || exit 1
Scripts/Build/libelf.sh      || exit 1
Scripts/Build/libffi.sh      || exit 1
Scripts/Build/openssl.sh     || exit 1
Scripts/Build/python.sh      || exit 1
Scripts/Build/ninja.sh       || exit 1
Scripts/Build/meson.sh       || exit 1
Scripts/Build/coreutils.sh   || exit 1
Scripts/Build/check.sh       || exit 1
Scripts/Build/diffutils.sh   || exit 1
Scripts/Build/gawk.sh        || exit 1
Scripts/Build/findutils.sh   || exit 1
Scripts/Build/groff.sh       || exit 1
Scripts/Build/grub.sh        || exit 1
Scripts/Build/less.sh        || exit 1
Scripts/Build/gzip.sh        || exit 1
Scripts/Build/iproute2.sh    || exit 1
Scripts/Build/kbd.sh         || exit 1
Scripts/Build/libpipeline.sh || exit 1
Scripts/Build/make.sh        || exit 1
Scripts/Build/patch.sh       || exit 1
Scripts/Build/man-db.sh      || exit 1
Scripts/Build/tar.sh         || exit 1
Scripts/Build/texinfo.sh     || exit 1
Scripts/Build/vim.sh         || exit 1
Scripts/Build/procps-ng.sh   || exit 1
Scripts/Build/util-linux.sh  || exit 1
Scripts/Build/e2fsprogs.sh   || exit 1
Scripts/Build/sysklogd.sh    || exit 1
Scripts/Build/sysvinit.sh    || exit 1
Scripts/Build/eudev.sh       || exit 1
