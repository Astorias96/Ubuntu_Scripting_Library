#!/bin/sh
### Written by Lemon Tree on 10.12.2020 ###
### This shell exports the default X11 display to the localhost. Works on Ubuntu 20.04 ###

### System variables ###
DATE=$(which "date")

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### Exporting X11 display ###
export DISPLAY=localhost:10.0

### Exiting ###
echo "\n$($CURRENT_DATE): The shell has finished running.\n\n$($CURRENT_DATE):Exiting.\n"
exit 0
