#!/bin/sh

echo "Building P11-Kit"

pushd /sources/additional

rm -rf p11-kit-0.23.15
tar -xf p11-kit-0.23.15.tar.gz
cd p11-kit-0.23.15

sed '20,$ d' -i trust/trust-extract-compat.in &&
cat >> trust/trust-extract-compat.in << "EOF"
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Generate a new trust store
/usr/sbin/make-ca -f -g
EOF
./configure --prefix=/usr --sysconfdir=/etc --with-trust-paths=/etc/pki/anchors || exit 1

make -j$MAKE_JOBS || exit 1
make -j$MAKE_JOBS check
make install || exit 1

ln -s /usr/libexec/p11-kit/trust-extract-compat /usr/bin/update-ca-certificates

ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so

cd ..
rm -rf p11-kit-0.23.15

popd
