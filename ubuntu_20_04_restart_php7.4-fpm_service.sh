#!/bin/sh
### Written by Lemon Tree on 20.08.2021 ###
### This shell restarts the PHP7.4-FPM service on the current device. ###

### System variables ###
DATE=$(which "date")
SYSTEMCTL=$(which "systemctl")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"

### Restarting PHP7.4-FPM service ###
echo "\n$($CURRENT_DATE): The shell has started...\n"
$SYSTEMCTL restart php7.4-fpm.service

### Exiting ###
echo "\n$($CURRENT_DATE): The shell has finished running.\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
