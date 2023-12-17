#!/bin/sh
### Written by Lemon Tree on 10.12.2020 ###
### This shell updates all repositories and packages for Ubuntu 22.04. It also removes all unecessary packages and libraries. ###

### System variables ###
APT_GET=$(which "apt-get")
DATE=$(which "date")
DPKG=$(which "dpkg")
SUDO=$(which "sudo")

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"

### Beginning operations ###
echo "\n$($CURRENT_DATE): The maintenance shell has started...\n"
$SUDO $APT_GET update &&
$SUDO $APT_GET upgrade -y &&
$SUDO $APT_GET full-upgrade -y &&
$SUDO $APT_GET install -f &&
$SUDO $DPKG --configure -a &&
$SUDO $APT_GET autoremove -y &&
$SUDO $APT_GET clean
$SUDO $APT_GET purge -y

### Exiting ###
echo "\n$($CURRENT_DATE): The maintenance shell has finished running.\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
