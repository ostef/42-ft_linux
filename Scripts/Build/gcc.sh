#!/bin/sh

echo "Building GCC"

pushd /sources

rm -rf gcc-8.2.0
tar -xf gcc-8.2.0.tar.xz
cd gcc-8.2.0

sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64

# Remove previous symlink to gcc
rm -f /usr/lib/gcc

mkdir -v build
cd build

SED=sed                      \
../configure --prefix=/usr   \
    --enable-languages=c,c++ \
    --disable-multilib       \
    --disable-bootstrap      \
    --disable-libmpx         \
    --with-system-zlib

make -j$MAKE_JOBS || exit 1

# Prevent the tests from overflowing the stack
ulimit -s 32768

# Remove a problematic test
rm ../gcc/testsuite/g++.dg/pr83239.C

# Test the results as a non priviledged user
chown -Rv nobody .
su nobody -s /bin/bash -c "PATH=$PATH make -k check"

../contrib/test_summary > /tmp/gcc-test-results
diff /tmp/gcc-test-results /42-ft_linux/Resources/Test-Results/gcc-8.2.0

make -j$MAKE_JOBS install || exit 1

ln -sv ../usr/bin/cpp /lib
ln -sv gcc /usr/bin/cc

# Enable building programs with link time optimization
install -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/8.2.0/liblto_plugin.so /usr/lib/bfd-plugins/

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

# Sanity checks
echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log || exit 1
readelf -l a.out | grep ': /lib64/ld-linux-x86-64.so.2' || exit 1

# @Todo: automatically check the output

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
echo "================"
echo "Output should be:"
echo "/usr/lib/gcc/x86_64-pc-linux-gnu/8.2.0/../../../../lib/crt1.o succeeded"
echo "/usr/lib/gcc/x86_64-pc-linux-gnu/8.2.0/../../../../lib/crti.o succeeded"
echo "/usr/lib/gcc/x86_64-pc-linux-gnu/8.2.0/../../../../lib/crtn.o succeeded"
echo "================"

grep -B4 '^ /usr/include' dummy.log
echo "================"
echo "Output should be:"
echo "#include <...> search starts here:"
echo " /usr/lib/gcc/x86_64-pc-linux-gnu/8.2.0/include"
echo " /usr/local/include"
echo " /usr/lib/gcc/x86_64-pc-linux-gnu/8.2.0/include-fixed"
echo " /usr/include"
echo "================"

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
echo "================"
echo "Output should contain:"
echo "SEARCH_DIR(\"/usr/x86_64-pc-linux-gnu/lib64\")"
echo "SEARCH_DIR(\"/usr/local/lib64\")"
echo "SEARCH_DIR(\"/lib64\")"
echo "SEARCH_DIR(\"/usr/lib64\")"
echo "SEARCH_DIR(\"/usr/x86_64-pc-linux-gnu/lib\")"
echo "SEARCH_DIR(\"/usr/local/lib\")"
echo "SEARCH_DIR(\"/lib\")"
echo "SEARCH_DIR(\"/usr/lib\");"
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

cd ../..
rm -rf gcc-8.2.0

popd
