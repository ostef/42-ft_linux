# ft_linux
This project is a LFS project. The requirements of this project are satisfied by following LFS 8.4, which is what I did.

## Pitfalls
* Building the packages must be done using the LFS user, not root (make sure the LFS user has access to $LFS/tools and al)
* Newer versions of make do not play well with older versions of glibc's build system. To downgrade to version 4.3, get it from wget https://ftp.gnu.org/gnu/make/make-4.3.tar.gz, build and install it and add /usr/local/bin to the PATH.
* There are a number of packages that are not available for download anymore at the default URLs. wget-list have been modified to use Oregon State University Open Source Lab Mirrors instead.

## Steps
```
$> sudo -E Scripts/prepare-system-files.sh
$> sudo -E Scripts/download-packages.sh
$> Scripts/build-temporary-system-tools.sh
$> sudo -E Scripts/prepare-virtual-system.sh
$> sudo -E Scripts/copy-repository.sh
$> sudo -E Scripts/enter-virtual-system.sh
$> /tools/bin/bash /42-ft_linux/Scripts/create-essential-files.sh
$>
```
### Upon (re)boot
Depends on your advancement in the steps above:
```
$> sudo -E Scripts/mount-filesystems.h
$> sudo -E Scripts/enter-virtual-system.sh
```
