#!/bin/sh
### Written by Lemon Tree on 18-12-2020 ###
### Requires Samba packages to run ###

### Command variables  ###
DATE=$(which "date")
GIO=$(which "gio")

### User-defined variables  ###
#SHARE="smb://your-drive/your-share"            # Uncomment and set to your share details

## Exit codes ##
MOUNT_FAILED="1"
MOUNT_SUCCESS="0"
VAR_SHARE_UNDEFINED="2"

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### Exit if $SHARE is not set
if [ -z "$SHARE" ]; then
    echo "\n$($CURRENT_DATE): The shell ran into an error - The share variable was not set (line 10) in the user-defined variables.\n$($CURRENT_DATE): Abort."
    exit $VAR_SHARE_UNDEFINED
fi

### Mounting share  ###
echo "\n$($CURRENT_DATE): Starting mount..."
$GIO mount "$SHARE"

## Exit with correct code ##
if [ $? = 0 ]; then
  echo "\n$($CURRENT_DATE): Successfully mounted the share $SHARE.\n$($CURRENT_DATE): Exiting.\n"
  exit $MOUNT_SUCCESS

else
  echo "\n$($CURRENT_DATE): The shell ran into an error.\n\n$($CURRENT_DATE): Abort.\n"
  exit $MOUNT_FAILED
fi