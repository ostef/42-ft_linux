#!/bin/bash


if [ "$(echo $LFS_BOOT_UUID)" = "" ]; then
	echo "ERROR: \$LFS_BOOT_UUID is not set"
	exit 1
fi

if [ "$(echo $LFS_ROOT_UUID)" = "" ]; then
	echo "ERROR: \$LFS_ROOT_UUID is not set"
	exit 1
fi

if [ "$(echo $LFS_SWAP_UUID)" = "" ]; then
	echo "ERROR: \$LFS_SWAP_UUID is not set"
	exit 1
fi

# Network configuration for my network card. Yours may be different/you might have more than one
# Do $> bash /lib/udev/init-net-rules.sh then $> cat /etc/udev/rules.d/70-persistent-net.rules
# to know what network cards have been assigned to what names
cat > /etc/sysconfig/ifconfig.enp0s3 << "EOF"
ONBOOT=yes
IFACE=enp0s3
SERVICE=ipv4-static
IP=192.168.1.2
GATEWAY=192.168.1.1
PREFIX=24
BROADCAST=192.168.1.255
EOF

# DNS configuration
cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4

# End /etc/resolv.conf
EOF

echo "soumanso" > /etc/hostname

# Hosts
cat > /etc/hosts << "EOF"
# Begin /etc/hosts

127.0.0.1    soumanso localhost
::1          soumanso localhost ip6-localhost ip6-loopback
ff02::1      ip6-allnodes
ff02::2      ip6-allrouters

# End /etc/hosts
EOF

cat > /etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

# End /etc/inittab
EOF

# Timezone
cat > /etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=1

# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.

CLOCKPARAMS=

# End /etc/sysconfig/clock
EOF

# Default shell environment
cat > /etc/profile << "EOF"
# Begin /etc/profile

export LANG=en_US.UTF-8

# End /etc/profile
EOF

# Readline configuration file
cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF

cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF

# === Boot configuration ===

# File system mount configuration upon boot
# @Todo: replace <xxx> <yyy> and <fff>
cat > /etc/fstab << EOF
# Begin /etc/fstab
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#

# file-system   mount-point type        options                 dump    fsck
#                                                                       order
UUID=$LFS_ROOT_UUID      /           ext4        defaults                1       1
UUID=$LFS_SWAP_UUID      swap        swap        pri=1                   0       0
UUID=$LFS_BOOT_UUID  /boot       vfat        umask=0077              0       1
proc            /proc       proc        nosuid,noexec,nodev     0       0
sysfs           /sys        sysfs       nosuid,noexec,nodev     0       0
devpts          /dev/pts    devpts      gid=5,mode=620          0       0
tmpfs           /run        tmpfs       defaults                0       0
devtmpfs        /dev        devtmpfs    mode=0755,nosuid        0       0

# End /etc/fstab
EOF

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg

set default=0
set timeout=5

insmod ext2
set root=(hd1,1)

menuentry "GNU/Linux, Linux 4.20.12-soumanso" {
    linux vmlinuz-4.20.12-soumanso root=PARTUUID=7bbfffc2-f7ff-4b79-854b-6aaa90afbd4a ro
}
EOF

echo 8.4 > /etc/lfs-release