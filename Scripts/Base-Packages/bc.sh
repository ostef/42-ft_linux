#!/bin/bash

echo "Building BC"

pushd /sources

rm -rf bc-1.07.1
tar -xf bc-1.07.1.tar.gz
cd bc-1.07.1

cat > bc/fix-libmath_h << "EOF"
#!/bin/bash
sed -e '1   s/^/{"/' \
    -e     's/$/",/' \
    -e '2,$ s/^/"/'  \
    -e   '$ d'       \
    -i libmath.h

sed -e '$ s/$/0}/' \
    -i libmath.h
EOF

ln -sv /tools/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6
ln -sfv libncursesw.so.6 /usr/lib/libncurses.so

sed -i -e '/flex/s/as_fn_error/: ;; # &/' configure

./configure --prefix=/usr   \
    --with-readline         \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info || exit 1

make -j$MAKE_JOBS || exit 1

echo "Running tests"
echo "quit" | ./bc/bc -l Test/checklib.b > /tmp/bc-test-results

make -j$MAKE_JOBS install || exit 1

cd ..
rm -rf bc-1.07.1

popd
