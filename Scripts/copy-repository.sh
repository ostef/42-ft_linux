#!/bin/bash

# This script is used to copy over the contents of this repository over the LFS when in chroot jail
# This script must be executed from outside the jail

if [ "$EUID" -ne 0 ]
then
    echo "ERROR: This script should be run as root!"
    exit 1
fi

if [ "$(echo $LFS)" = "" ]; then
	echo "ERROR: \$LFS is not set"
	exit 1
fi

rm -rf $LFS/42-ft_linux
cp -r ../42-ft_linux $LFS/
