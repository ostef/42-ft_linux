#!/bin/sh

echo "Building Libffi"

pushd /sources

rm -rf libffi-3.2.1
tar -xf libffi-3.2.1.tar.gz
cd libffi-3.2.1

sed -e '/^includesdir/ s/$(libdir).*$/$(includedir)/' -i include/Makefile.in
sed -e '/^includedir/ s/=.*$/=@includedir@/' -e 's/^Cflags: -I${includedir}/Cflags:/' -i libffi.pc.in

./configure --prefix=/usr --disable-static --with-gcc-arch=native || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf libffi-3.2.1

popd
