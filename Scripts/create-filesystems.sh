#!/bin/sh

if [ "$(echo $LFS_DISK)" = "" ]; then
	echo "ERROR: \$LFS_DISK is not set"
	exit 1
fi

mkfs.fat -F 32 -v /dev/"$LFS_DISK"1
mkfs.ext4 -v /dev/"$LFS_DISK"2
mkswap /dev/"$LFS_DISK"3
