#!/bin/sh

if [ "$(echo $LFS)" = "" ]; then
	printf "ERROR: \$LFS is not set\n"
	exit 1
fi

mount --mkdir /dev/sdb2 $LFS
mount --mkdir /dev/sdb1 $LFS/boot
swapon -v /dev/sdb3
