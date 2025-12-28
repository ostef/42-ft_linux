# Turn off bash hashing, which caches the results of PATH searches. We want to always lookup the PATH!
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
MAKE_JOBS=10
export LFS LC_ALL LFS_TGT PATH MAKE_JOBS
