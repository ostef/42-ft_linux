#!/bin/sh
mkfs.fat -F 32 -v /dev/sdb1
mkfs.ext4 -v /dev/sdb2
mkswap /dev/sdb3
