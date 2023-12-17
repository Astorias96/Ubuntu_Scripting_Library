#!/bin/sh
### Written by Lemon Tree on 27.02.2021 ###
### This shell is fixing this issue - Broken pipe error when using the built-in unix shutdown/reboot daemon over SSH - Ubuntu 20.04 ###

### System variables ###
CP=$(which "cp")
DATE=$(which "date")
SUDO=$(which "sudo")
SYSTEMCTL=$(which "systemctl")

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The troubleshooting shell has started."
echo "\n$($CURRENT_DATE): Administrative privileges are required to run this shell."

## Copy the missing ssh-session-cleanup service to the systemd/system directory ##
$SUDO $CP "/usr/share/doc/openssh-client/examples/ssh-session-cleanup.service" "/etc/systemd/system/"

## Restart the ssh-session-cleanup service ##
$SUDO $SYSTEMCTL enable ssh-session-cleanup.service

read -p "Do you wish to use the fix without rebooting your device ? (y/n) " RESPONSE
if [ $RESPONSE = "y" ] || [ $RESPONSE = "Y" ] || [ $RESPONSE = "yes" ] || [ $RESPONSE = "Yes" ]; then
  ## Reload the system daemon ##
  $SUDO $SYSTEMCTL daemon-reload
  ## Start the ssh-session-cleanup service manually ##
  $SUDO $SYSTEMCTL start ssh-session-cleanup.service
  echo "\n$($CURRENT_DATE): The daemon has been reloaded and the ssh-session-cleanup service was started manually.\n\n$($CURRENT_DATE): The troubleshooting shell has finished running."
elif [ $RESPONSE = "n" ] || [ $RESPONSE = "N" ] || [ $RESPONSE = "no" ] || [ $RESPONSE = "No" ]; then
  echo "\n$($CURRENT_DATE): The troubleshooting shell has finished running.\n$($CURRENT_DATE): To apply the fix, restart the device manually.\n"
else
  echo "\n$($CURRENT_DATE): This option has been skipped. The troubleshooting shell has finished running.\n$($CURRENT_DATE): To apply the fix, restart the device manually.\n"
fi

### Exiting ###
echo "\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
