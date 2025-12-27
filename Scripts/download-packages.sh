#!/bin/sh

rm -rf $LFS/sources/*
wget --input-file=Resources/wget-list --continue --directory-prefix=$LFS/sources

cp Resources/md5sums $LFS/md5sums

pushd $LFS/sources
md5sum -c md5sums
popd
