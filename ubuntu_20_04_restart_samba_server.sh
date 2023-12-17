#!/bin/sh
### Written by Lemon Tree on 29-12-2020 ###
### This shell restarts the samba-server on Ubuntu 20.04 ###

### System variables ###
DATE=$(which "date")
SUDO=$(which "sudo")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### User-defined variables ###
SMBD="/etc/init.d/smbd"

### Restart samba-server ###
echo "\n$($CURRENT_DATE): Initiating the samba server service restart..."
$SUDO $SMBD restart

### Checking for success or failure ###
if [ $? = 0 ]; then
  echo "\n$($CURRENT_DATE): The samba server service was restarted successfully.\n\nExiting.\n"
  exit 0

else
  echo "\n$($CURRENT_DATE): The samba server service failed to restart.\n\nExiting.\n"
  exit 1

fi
