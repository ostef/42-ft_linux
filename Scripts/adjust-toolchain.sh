#!/bin/sh

# This script is executed after having installed the Linux API headers,
# Man pages and Glibc packages on the final system

# Backup /tools linker and replace it with the one we made when building the temporary tools
mv -v /tools/bin/{ld,ld-old}
mv -v /tools/$(uname -m)-pc-linux-gnu/bin/{ld,ld-old}
mv -v /tools/bin/{ld-new,ld}
ln -sv /tools/bin/ld /tools/$(uname -m)-pc-linux-gnu/bin/ld

# Modify the GCC specs to use our new linker and to find the correct headers
gcc -dumpspecs | sed -e 's@/tools@@g'                   \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
    `dirname $(gcc --print-libgcc-file-name)`/specs

# Sanity check
echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log || exit 1
readelf -l a.out | grep ': /lib' || exit 1

# @Todo: automatically check the output

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
# Output should be:
# /usr/lib/../lib/crt1.o succeeded
# /usr/lib/../lib/crti.o succeeded
# /usr/lib/../lib/crtn.o succeeded

grep -B1 '^ /usr/include' dummy.log
# Output should be:
# #include <...> search starts here:
# /usr/include

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
# Output should be:
# SEARCH_DIR("/usr/lib")
# SEARCH_DIR("/lib")

grep "/lib.*/libc.so.6 " dummy.log
# Output should be:
# attempt to open /lib/libc.so.6 succeeded

grep found dummy.log
# Output should be:
# found ld-linux-x86-64.so.2 at /lib/ld-linux-x86-64.so.2

rm -v dummy.c a.out dummy.log
