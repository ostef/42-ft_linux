# ft_linux
This project is a LFS project. The requirements of this project are satisfied by following LFS 8.4, which is what I did.

In the .bashrc file, the MAKE_JOBS variable must be changed to match your machine's capabilities.
In the prepare-filesystem-files.sh script, make sure your username is used for the chowns.

There are additional packages that are downloaded and built alongside the base LFS ones as suggested in the subject.

## Pitfalls
* Building the packages must be done using the LFS user, not root (make sure the LFS user has access to $LFS/tools and al)
* Newer versions of make do not play well with older versions of glibc's build system. To downgrade to version 4.3, get it from wget https://ftp.gnu.org/gnu/make/make-4.3.tar.gz, build and install it and add /usr/local/bin to the PATH.
* There are a number of packages that are not available for download anymore at the default URLs. wget-list have been modified to use Oregon State University Open Source Lab Mirrors instead.
* The name of the disk devices can change after a reboot. For that reason, you need to define the LFS_DISK env variable to whatever disk is the LFS disk (e.g. sdb)

## Steps
```
$> export LFS_USER=??
$> export LFS_DISK=sd??
$> sudo -E Scripts/prepare-system-files.sh
$> sudo -E Scripts/download-packages.sh
$> sudo -E Scripts/download-additional-packages.sh
$> Scripts/build-temp-packages.sh
$> sudo -E Scripts/prepare-virtual-system.sh
$> sudo -E Scripts/copy-repository.sh
$> sudo -E Scripts/enter-virtual-system.sh
$> /tools/bin/bash /42-ft_linux/Scripts/create-essential-files.sh
$> exit
$> sudo -E Scripts/enter-virtual-system.sh
$> cd /42-ft_linux
$> Scripts/build-base-packages.sh
$> Scripts/clean-up.sh
$> exit
$> sudo -E Scripts/enter-final-virtual-system.sh
$> /42-ft_linux/final-config.sh
$> Scripts/build-additional-packages.sh
```
### Upon reboot
Depending on your advancement in the steps above:
```
$> export LFS_USER=??
$> export LFS_DISK=sd??
$> sudo -E Scripts/mount-filesystems.sh
$> sudo -E Scripts/prepare-virtual-system.sh
$> sudo -E Scripts/enter-{final}-virtual-system.sh # Depending on whether all system packages have been built or not
```
