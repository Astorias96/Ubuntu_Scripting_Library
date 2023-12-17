#!/bin/sh
### Written by Lemon Tree on 10.12.2020 ###
### This shell removes the Radeon HD 7970-8970 graphic drivers for Ubuntu 20.04 ###
### https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html ###

### Command variables ###
APT=$(which "apt")
DATE=$(which "date")
REBOOT=$(which "reboot")
SUDO=$(which "sudo")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### Starting removal ###
echo "\n$($CURRENT_DATE): Starting removal: Administrative privileges are required to run this installation shell.\n"
$SUDO $APT autoremove rocm-opencl rocm-dkms rocm-dev rocm-utils

### Reboot & exiting ###
echo "\n$($CURRENT_DATE): The script has finished running. Your device needs to reboot."
read -n 1 -s -r -p "Press any key to reboot and finish the installation process"
$SUDO $REBOOT && exit 0
