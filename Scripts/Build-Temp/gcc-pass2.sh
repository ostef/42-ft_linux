#!/bin/sh

echo "Building GCC - Pass 2"

if [ "$EUID" -eq 0 ]
then
    echo "Do not run as root!"
    exit 1
fi

pushd $LFS/sources

rm -rf gcc-8.2.0
tar -xf gcc-8.2.0.tar.xz
cd gcc-8.2.0

tar -xf ../mpfr-4.0.2.tar.xz
mv -v mpfr-4.0.2 mpfr
tar -xf ../gmp-6.1.2.tar.xz
mv -v gmp-6.1.2 gmp
tar -xf ../mpc-1.1.0.tar.gz
mv -v mpc-1.1.0 mpc

cat gcc/limitx.h gcc/glimits.h gcc/limity.h > `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

for file in gcc/config/{linux,i386/linux{,64}}.h
do
    cp -uv $file{,.orig}
    sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' -e 's@/usr@/tools@g' $file.orig > $file
    echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
    touch $file.orig
done

sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64

mkdir -v build
cd build

CC=$LFS_TGT-gcc                                    \
CXX=$LFS_TGT-g++                                   \
AR=$LFS_TGT-ar                                     \
RANLIB=$LFS_TGT-ranlib                             \
../configure                                       \
    --prefix=/tools                                \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++                       \
    --disable-libstdcxx-pch                        \
    --disable-multilib                             \
    --disable-bootstrap                            \
    --disable-libgomp || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS install || exit 1

ln -sv gcc /tools/bin/cc

cd ../..
rm -rf gcc-8.2.0

popd

# Sanity check
echo 'int main(){}' > dummy.c
cc dummy.c || exit 1
readelf -l a.out | grep ': /tools' || exit 1
rm -vf dummy.c a.out
