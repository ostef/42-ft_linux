#!/bin/sh

if [ "$(echo $LFS)" = "" ]; then
	echo "ERROR: \$LFS is not set"
	exit 1
fi

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

passwd lfs << "END"
lfs
END

chown -v lfs $LFS/tools
chown -v lfs $LFS/sources
