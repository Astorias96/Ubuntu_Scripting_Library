#!/bin/sh
### Written by Lemon Tree on 28-12-2020 ###
### This shell displays the disk information for the system drive and the data drive on the current system. ###

### Command variables ###
DATE=$(which "date")
DF=$(which "df")
GREP=$(which "grep")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### User-defined variables ###
SYSTEM_DISK="/dev/sda2"
DATA_DISK="/dev/sdb1"

### Displaying disk information to the user ###
# System drive #
echo "\nInformation on the System disk:\n"
$DF -h $SYSTEM_DISK

# Data drive #
echo "\nInformation on the Data disk:\n"
$DF -h $DATA_DISK

# Exiting #
echo "\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
