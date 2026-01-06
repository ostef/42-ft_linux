#!/bin/bash

if [ "$EUID" -ne 0 ]
then
    echo "ERROR: This script should be run as root!"
    exit 1
fi

if [ "$(echo $LFS)" = "" ]; then
	echo "ERROR: \$LFS is not set"
	exit 1
fi

chroot "$LFS" /usr/bin/env -i          \
    HOME=/root                         \
    TERM="$TERM"                       \
    PS1='(lfs chroot) \u:\w\$ '        \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login
