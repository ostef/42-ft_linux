#!/bin/sh

Scripts/Base-Packages/linux-api-headers.sh || exit 1
Scripts/Base-Packages/man-pages.sh         || exit 1
Scripts/Base-Packages/glibc.sh             || exit 1

Scripts/ajust-toolchain.sh || exit 1

Scripts/Base-Packages/zlib.sh       || exit 1
Scripts/Base-Packages/file.sh       || exit 1
Scripts/Base-Packages/readline.sh   || exit 1
Scripts/Base-Packages/m4.sh         || exit 1
Scripts/Base-Packages/bc.sh         || exit 1
Scripts/Base-Packages/binutils.sh   || exit 1
Scripts/Base-Packages/gmp.sh        || exit 1
Scripts/Base-Packages/mpfr.sh       || exit 1
Scripts/Base-Packages/mpc.sh        || exit 1
Scripts/Base-Packages/shadow.sh     || exit 1
Scripts/Base-Packages/gcc.sh        || exit 1
Scripts/Base-Packages/bzip2.sh      || exit 1
Scripts/Base-Packages/pkg-config.sh || exit 1
Scripts/Base-Packages/ncurses.sh    || exit 1
Scripts/Base-Packages/attr.sh       || exit 1
Scripts/Base-Packages/acl.sh        || exit 1
Scripts/Base-Packages/libcap.sh     || exit 1
Scripts/Base-Packages/sed.sh        || exit 1
Scripts/Base-Packages/psmisc.sh     || exit 1
Scripts/Base-Packages/iana-etc.sh   || exit 1
Scripts/Base-Packages/bison.sh      || exit 1
Scripts/Base-Packages/flex.sh       || exit 1
Scripts/Base-Packages/grep.sh       || exit 1
Scripts/Base-Packages/bash.sh       || exit 1

# At this point, we could use the newly built bash (and in the LFS book this is what they do)
# but this means we need to make a break in the build process, which I don't like
# I think it's fine to use /tools/bash

Scripts/Base-Packages/libtool.sh     || exit 1
Scripts/Base-Packages/gdbm.sh        || exit 1
Scripts/Base-Packages/gperf.sh       || exit 1
Scripts/Base-Packages/expat.sh       || exit 1
Scripts/Base-Packages/inetutils.sh   || exit 1
Scripts/Base-Packages/perl.sh        || exit 1
Scripts/Base-Packages/xml-parser.sh  || exit 1
Scripts/Base-Packages/intltool.sh    || exit 1
Scripts/Base-Packages/autoconf.sh    || exit 1
Scripts/Base-Packages/automake.sh    || exit 1
Scripts/Base-Packages/xz.sh          || exit 1
Scripts/Base-Packages/kmod.sh        || exit 1
Scripts/Base-Packages/gettext.sh     || exit 1
Scripts/Base-Packages/libelf.sh      || exit 1
Scripts/Base-Packages/libffi.sh      || exit 1
Scripts/Base-Packages/openssl.sh     || exit 1
Scripts/Base-Packages/python.sh      || exit 1
Scripts/Base-Packages/ninja.sh       || exit 1
Scripts/Base-Packages/meson.sh       || exit 1
Scripts/Base-Packages/coreutils.sh   || exit 1
Scripts/Base-Packages/check.sh       || exit 1
Scripts/Base-Packages/diffutils.sh   || exit 1
Scripts/Base-Packages/gawk.sh        || exit 1
Scripts/Base-Packages/findutils.sh   || exit 1
Scripts/Base-Packages/groff.sh       || exit 1
Scripts/Base-Packages/grub.sh        || exit 1
Scripts/Base-Packages/less.sh        || exit 1
Scripts/Base-Packages/gzip.sh        || exit 1
Scripts/Base-Packages/iproute2.sh    || exit 1
Scripts/Base-Packages/kbd.sh         || exit 1
Scripts/Base-Packages/libpipeline.sh || exit 1
Scripts/Base-Packages/make.sh        || exit 1
Scripts/Base-Packages/patch.sh       || exit 1
Scripts/Base-Packages/man-db.sh      || exit 1
Scripts/Base-Packages/tar.sh         || exit 1
Scripts/Base-Packages/texinfo.sh     || exit 1
Scripts/Base-Packages/vim.sh         || exit 1
Scripts/Base-Packages/procps-ng.sh   || exit 1
Scripts/Base-Packages/util-linux.sh  || exit 1
Scripts/Base-Packages/e2fsprogs.sh   || exit 1
Scripts/Base-Packages/sysklogd.sh    || exit 1
Scripts/Base-Packages/sysvinit.sh    || exit 1
Scripts/Base-Packages/eudev.sh       || exit 1

Scripts/Base-Packages/bootscripts.sh || exit 1
