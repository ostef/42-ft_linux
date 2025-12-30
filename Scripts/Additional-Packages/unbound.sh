#!/bin/sh

echo "Building Unbound"

pushd /sources/additional

rm -rf unbound-1.9.0
tar -xf unbound-1.9.0.tar.gz
cd unbound-1.9.0

groupadd -g 88 unbound || exit 1
useradd -c "Unbound DNS resolver" -d /var/lib/unbound -u 88 -g unbound -s /bin/false unbound

./configure --prefix=/usr --sysconfdir=/etc --disable-static --with-pidfile=/run/unbound.pid || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make -j$MAKE_JOBS install || exit 1

mv -v /usr/sbin/unbound-host /usr/bin/

cd ..
rm -rf unbound-1.9.0

popd
