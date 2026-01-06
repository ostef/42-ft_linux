#!/bin/bash

echo "Building Inetutils"

pushd /sources

rm -rf inetutils-1.9.4
tar -xf inetutils-1.9.4.tar.xz
cd inetutils-1.9.4

./configure --prefix=/usr \
    --localstatedir=/var  \
    --disable-logger      \
    --disable-whois       \
    --disable-rcp         \
    --disable-rexec       \
    --disable-rlogin      \
    --disable-rsh         \
    --disable-servers || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin

cd ..
rm -rf inetutils-1.9.4

popd
