#!/bin/sh
### Written by Lemon Tree on 10.12.2020 ###
### This shell installs the Radeon HD 7970-8970 graphic drivers for Ubuntu 20.04 ###
### https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html ###

### Command variables ###
APT_GET=$(which "apt-get")
APT_KEY=$(which "apt-key")
DATE=$(which "date")
REBOOT=$(which "reboot")
SUDO=$(which "sudo")
TEE=$(which "tee")
USERMOD=$(which "usermod")
WGET=$(which "wget")
WHOAMI=$(which "whoami")

### User-defined variables ###
USERNAME=$($WHOAMI)

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### Update system ###
echo "\n$($CURRENT_DATE): Administrative privileges are required to run this installation shell.\n"
$SUDO $APT_GET update ; $SUDO $APT_GET dist-upgrade ; $SUDO $APT_GET install libnuma-dev

### Add Radeon repository ###
$WGET -q -O - https://repo.radeon.com/rocm/rocm.gpg.key | $SUDO $APT_KEY add -
echo 'deb [arch=amd64] https://repo.radeon.com/rocm/apt/debian/ xenial main' | $SUDO $TEE /etc/apt/sources.list.d/rocm.list

### Install pre-requisites ###
echo "\n$($CURRENT_DATE): Updating packages repositories...\n"
$SUDO $APT_GET update ; $SUDO $APT_GET install rocm-dkms

### Install recommended packages ###
echo "\n$($CURRENT_DATE): Installing pre-requisites and driver packages...\n"
$SUDO $APT_GET install menu -y ; $SUDO $APT_GET install debian-keyring -y ; $SUDO $APT_GET install gcc-9-doc -y ; $SUDO $APT_GET install lib32stdc++6-9-dbg -y ; $SUDO $APT_GET install libx32stdc++6-9-dbg -y ; $SUDO $APT_GET install libtool -y ; $SUDO $APT_GET install flex -y ; $SUDO $APT_GET install $SUDO $APT_GET install bison -y ; $SUDO $APT_GET install gcc-doc -y ; $SUDO $APT_GET install gcc-9-locales -y ; $SUDO $APT_GET install libstdc++-7-doc -y ; $SUDO $APT_GET install libx11-doc -y ; $SUDO $APT_GET install libxcb-doc -y ; $SUDO $APT_GET install make-doc -y

### Add $USER to the correct group  ###
echo "\n$($CURRENT_DATE): Adding $USERNAME to the needed groups..."
$SUDO $USERMOD -a -G video $USERNAME
$SUDO $USERMOD -a -G render $USERNAME

### Add future users to the groups ###
echo 'ADD_EXTRA_GROUPS=1' | $SUDO $TEE -a /etc/adduser.conf
echo 'EXTRA_GROUPS=video' | $SUDO $TEE -a /etc/adduser.conf
echo 'EXTRA_GROUPS=render' | $SUDO $TEE -a /etc/adduser.conf

### Add ROC binaries to PATH ###
echo 'export PATH=$PATH:/opt/rocm/bin:/opt/rocm/rocprofiler/bin:/opt/rocm/opencl/bin' | $SUDO $TEE -a /etc/profile.d/rocm.sh

### Reboot & exit ###
echo "\n$($CURRENT_DATE): The script has finished running. Your device needs to reboot."
read -n 1 -s -r -p "Press any key to reboot and finish the installation process"
$SUDO $REBOOT & exit 0
