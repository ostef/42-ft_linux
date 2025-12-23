#!/bin/sh

Scripts/install-required-packages.sh || exit 1
Scripts/version-check.sh || exit 1
Scripts/create-partitions.sh || exit 1
Scripts/create-filesystems.sh || exit 1

export LFS=/mnt/lfs

Scripts/mount-filesystems.sh || exit 1
