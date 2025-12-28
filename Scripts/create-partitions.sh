#!/bin/sh
fdisk /dev/sdb << "END"
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