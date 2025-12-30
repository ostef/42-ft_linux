#!/bin/sh

echo "Building M4"

pushd /sources

rm -rf m4-1.4.18
tar -xf m4-1.4.18.tar.xz
cd m4-1.4.18

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf m4-1.4.18

popd
