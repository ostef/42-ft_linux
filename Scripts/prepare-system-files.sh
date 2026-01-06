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

if [ "$(echo $LFS_USER)" = "" ]; then
	echo "ERROR: \$LFS_USER is not set"
	exit 1
fi

rm /home/$LFS_USER/.bashrc
cp -v Resources/.bashrc /home/$LFS_USER/.bashrc || exit 1
chown -v $LFS_USER /home/$LFS_USER/.bashrc || exit 1

source ~/.bashrc

Scripts/install-host-packages.sh || exit 1
Scripts/version-check.sh || exit 1
Scripts/create-partitions.sh || exit 1
Scripts/create-filesystems.sh || exit 1
Scripts/mount-filesystems.sh || exit 1

mkdir -v $LFS/sources || exit 1
chmod -v a+wt $LFS/sources || exit 1
chown -v $LFS_USER $LFS/tools || exit 1

mkdir -v $LFS/tools || exit 1
chown -v $LFS_USER $LFS/tools
ln -sv $LFS/tools /tools || exit 1

mkdir -v /tools/lib || exit 1
chown -v $LFS_USER $LFS/tools/lib || exit 1
ln -sv lib /tools/lib64 || exit 1
