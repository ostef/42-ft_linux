#!/bin/sh

echo "Building Meson"

pushd /sources

rm -rf meson-0.49.2
tar -xf meson-0.49.2.tar.gz
cd meson-0.49.2

python3 setup.py build || exit 1

python3 setup.py install --root=dest || exit 1
cp -rv dest/* /

cd ..
rm -rf meson-0.49.2

popd
