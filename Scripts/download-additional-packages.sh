#!/bin/sh

mkdir -pv $LFS/sources/additional
rm -rf $LFS/sources/additional/*

wget --input-file=Resources/additional-packages --continue --directory-prefix=$LFS/sources/additional
