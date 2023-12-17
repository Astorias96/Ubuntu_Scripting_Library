#!/bin/sh
### Written by Lemon Tree on 20.08.2021 ###
### This shell restarts the Nginx service on the current device. ###

### System variables ###
DATE=$(which "date")
SYSTEMCTL=$(which "systemctl")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"

### Restarting Nginx service ###
echo "\n$($CURRENT_DATE): The shell has started...\n"
$SYSTEMCTL restart nginx.service

### Exiting ###
echo "\n$($CURRENT_DATE): The shell has finished running.\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
