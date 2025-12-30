#!/bin/sh

echo "Building Texinfo"

pushd /sources

rm -rf texinfo-6.5
tar -xf texinfo-6.5.tar.xz
cd texinfo-6.5

sed -i '5481,5485 s/({/(\\{/' tp/Texinfo/Parser.pm

./configure --prefix=/usr --disable-static || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1
make TEXMF=/usr/share/texmf install-tex

pushd /usr/share/info

rm -v dir
for f in *
    do install-info $f dir 2>/dev/null
done

popd

cd ..
rm -rf texinfo-6.5

popd
