#!/bin/sh
### Written by Lemon Tree on 29-12-2020 ###
### This shell restarts the sshd server on Ubuntu 20.04 ###

### System variables ###
DATE=$(which "date")
SUDO=$(which "sudo")
SYSTEMCTL=$(which "systemctl")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### Restart samba-server ###
echo "\n$($CURRENT_DATE): Initiating the sshd server service restart..."
$SUDO $SYSTEMCTL restart ssh

### Checking for success or failure ###
if [ $? = 0 ]; then
  echo "\n$($CURRENT_DATE): The sshd service was restarted successfully.\n\nExiting.\n"
  exit 0

else
  echo "\n$($CURRENT_DATE): The sshd service failed to restart.\n\nExiting.\n"
  exit 1

fi
