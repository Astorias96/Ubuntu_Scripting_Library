#!/bin/sh
### Written by Lemon Tree on 20-11-2020 ###
### This shell should be placed in the home directory. It calls the ubuntu_22_04_update_system.sh script. Works with Ubuntu 22.04 ###

### System variables ###
DATE=$(which "date")
SH=$(which "sh")
SUDO=$(which "sudo")
WHOAMI=$(which "whoami")

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

## Get current logged-in user ##
CURRENT_USER=$($WHOAMI)

### Start update shell ###
echo "\n$($CURRENT_DATE): Administrative privileges are required to run this shell."
$SUDO $SH "/home/$CURRENT_USER/scripts/ubuntu_22_04_update_system.sh" &&
## Start NextCloud applications update - use with caution ##
#$SH "/home/$CURRENT_USER/scripts/ubuntu_20_04_nextcloud_update_applications.sh" &&

### Exiting ###
exit 0
