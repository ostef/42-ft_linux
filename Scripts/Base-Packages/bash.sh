#!/bin/bash

echo "Building Bash"

pushd /sources

rm -rf bash-5.0
tar -xf bash-5.0.tar.gz
cd bash-5.0

./configure --prefix=/usr            \
    --docdir=/usr/share/doc/bash-5.0 \
    --without-bash-malloc            \
    --with-installed-readline

make -j$MAKE_JOBS || exit 1

chown -Rv nobody .
su nobody -s /bin/bash -c "PATH=$PATH HOME=/home make tests"

make -j$MAKE_JOBS install || exit 1

mv -vf /usr/bin/bash /bin

cd ..
rm -rf bash-5.0

popd
