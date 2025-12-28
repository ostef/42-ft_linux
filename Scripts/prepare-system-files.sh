#!/bin/sh

Scripts/install-required-packages.sh || exit 1
Scripts/version-check.sh || exit 1
Scripts/create-partitions.sh || exit 1
Scripts/create-filesystems.sh || exit 1
Scripts/mount-filesystems.sh || exit 1

mkdir -v $LFS/sources || exit 1
chmod -v a+wt $LFS/sources || exit 1
chown -v stefan $LFS/tools || exit 1

mkdir -v $LFS/tools || exit 1
chown -v stefan $LFS/tools
ln -sv $LFS/tools /tools || exit 1

mkdir -v /tools/lib || exit 1
chown -v stefan $LFS/tools/lib || exit 1
ln -sv lib /tools/lib64 || exit 1
