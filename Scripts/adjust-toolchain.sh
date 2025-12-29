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
readelf -l a.out | grep ': /lib64/ld-linux-x86-64.so.2' || exit 1

# @Todo: automatically check the output

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
echo "================"
echo "Output should be:"
echo "/usr/lib/../lib/crt1.o succeeded"
echo "/usr/lib/../lib/crti.o succeeded"
echo "/usr/lib/../lib/crtn.o succeeded"
echo "================"

grep -B1 '^ /usr/include' dummy.log
echo "================"
echo "Output should be:"
echo "#include <...> search starts here:"
echo "/usr/include"
echo "================"

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
echo "================"
echo "Output should contain:"
echo "SEARCH_DIR(\"/usr/lib\")"
echo "SEARCH_DIR(\"/lib\")"
echo "================"

grep "/lib.*/libc.so.6 " dummy.log
echo "================"
echo "Output should be:"
echo "attempt to open /lib/libc.so.6 succeeded"
echo "================"

grep found dummy.log
echo "================"
echo "Output should be:"
echo "found ld-linux-x86-64.so.2 at /lib/ld-linux-x86-64.so.2"
echo "================"

rm -v dummy.c a.out dummy.log
