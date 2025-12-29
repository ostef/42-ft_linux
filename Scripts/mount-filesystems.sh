#!/bin/sh

if [ "$EUID" -ne 0 ]
then
    echo "ERROR: This script should be run as root!"
    exit 1
fi

if [ "$(echo $LFS)" = "" ]; then
	echo "ERROR: \$LFS is not set"
	exit 1
fi

if [ "$(echo $LFS_DISK)" = "" ]; then
	echo "ERROR: \$LFS_DISK is not set"
	exit 1
fi

mount --mkdir /dev/"$LFS_DISK"2 $LFS
mount --mkdir /dev/"$LFS_DISK"1 $LFS/boot
swapon -v /dev/"$LFS_DISK"3
