#!/bin/bash

echo "Building Man-pages"

pushd /sources

rm -rf man-pages-4.16
tar -xf man-pages-4.16.tar.xz
cd man-pages-4.16

make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf man-pages-4.16

popd
