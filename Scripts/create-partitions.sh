#!/bin/bash

if [ "$(echo $LFS_DISK)" = "" ]; then
	echo "ERROR: \$LFS_DISK is not set"
	exit 1
fi

fdisk /dev/$LFS_DISK << "END"
g
n


+512M
t
1
n


+15G
n


+2G
t

19
p
w
END