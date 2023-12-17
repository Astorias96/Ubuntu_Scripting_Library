#!/bin/sh
### Written by Lemon Tree on 05.01.2021 ###
### This shell displays system information in a terminal using neofetch. ###

### System variables ###
DATE=$(which "date")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"

### Checking if neofetch is installed & abort if not found
command -v neofetch >/dev/null 2>&1 || { echo >&2 "\n$($CURRENT_DATE): This shell requires the neofetch binary, but it was not found installed.\n$($CURRENT_DATE): Abort."; exit 1; }

### Declare neofetch variable if found
NEOFETCH=$(which "neofetch")

### Beginning operations ###
echo "\n$($CURRENT_DATE): Neofetch was found, displaying system information.\n"
$NEOFETCH --shell_path on --shell_version on --memory_percent on

### Exiting ###
echo "\n$($CURRENT_DATE): The shell has finished running.\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
