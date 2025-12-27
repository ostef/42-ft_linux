# ft_linux

## Partitioning the disk
The first step is to partition the disk that will contain our Linux system. When installing a Linux distribution, this is often done by the installer, but we are going to do this by hand.

In the VM we create an additional hard drive of 20GB which we will use for our system. This will most likely be /dev/sdb.

We use fdisk to partition the disk, all the commands are in Scripts/create-partitions.sh. This is what our partitions will look like:
| 1: 512M, EFI mounted at /boot/efi | 2: 2G, Linux Swap | 3: 15G, Linux System mounted at / |

```
g       # Create a new empty GPT partition table
n       # Create a new partition (this will be our EFI boot partition for grub)
        # Partition number (empty)
        # First sector (empty)
+512M   # Last sector
t       # Change the type of a partition (default is Linux filesystem)
1       # Partition number
1       # New partition type (1 is for EFI System)
n       # Create a new partition (this will be our primary partition)
        # Partition number (empty)
        # First sector (empty)
+15G    # Last sector
n       # Create a new partition (this will be our swap partition)
        # Partition number (empty)
        # First sector (empty)
+2G     # Last sector
t       # Change the type of a partition (default is Linux filesystem)
1       # Partition number
19      # New partition type (19 is for Linux Swap)
p       # Print partitions
w       # Write all changes to disk
```
Results should be:
/dev/sdb1 -> EFI boot partition
/dev/sdb2 -> Main Linux partition
/dev/sdb3 -> Swap partition

## Steps to do upon host boot
`export LFS=/mnt/lfs`
Execute Scripts/mount-filesystems.sh (use sudo -E to preserve env)

## Missing packages
There are a number of packages that are not available for download anymore. wget-list have been modified accordingly after finding other places to find packages.

The following packages were causing problems:
* acl-2.2.53.tar.gz
* attr-2.4.48.tar.gz
* expat-2.2.6.tar.bz2
* lfs-bootscripts-20180820.tar.bz2
* libpipeline-1.5.1.tar.gz
* man-pages-4.16.tar.xz
* psmisc-23.2.tar.xz
* sysvinit-2.93.tar.xz
* vim-8.1.tar.bz2
* zlib-1.2.11.tar.xz, this one has been replaced by zlib-1.2.11.tar.gz so the md5sum does not match
* bzip2-1.0.6-install_docs-1.patch
* coreutils-8.30-i18n-1.patch
* glibc-2.29-fhs-1.patch
* kbd-2.0.4-backspace-1.patch
* sysvinit-2.93-consolidated-1.patch
