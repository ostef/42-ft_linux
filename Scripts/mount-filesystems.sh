#!/bin/sh

if [ "$(echo $LFS)" = "" ]; then
	echo "ERROR: \$LFS is not set"
	exit 1
fi

mount --mkdir /dev/sdb2 $LFS
mount --mkdir /dev/sdb1 $LFS/boot
swapon -v /dev/sdb3
