#!/bin/sh
### Written by Lemon Tree on 05.01.2021 ###
### This shell restarts the Apache2 service on the current device. ###

### System variables ###
DATE=$(which "date")
SYSTEMCTL=$(which "systemctl")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"

### Restarting Apache2 service ###
echo "\n$($CURRENT_DATE): The shell has started...\n"
$SYSTEMCTL restart apache2

### Exiting ###
echo "\n$($CURRENT_DATE): The shell has finished running.\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
