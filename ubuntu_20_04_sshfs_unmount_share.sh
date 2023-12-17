#!/bin/sh
## Written by Lemon Tree on 05-04-2021 ##
## This shell unmounts a SSHFS share using the specified parameters (in the shell variables). ##

## System variables ##
DATE=$(which "date")
SUDO=$(which "sudo")
UMOUNT=$(which "umount")

## User-defined variables ##
#MOUNTPOINT="/your/mount/path/"                  # Uncomment and set to your mountpoint details
#SHARE_NAME="YOUR-SHARE-NAME"                    # Uncomment and set to your share details

## Exit codes ##
UNMOUNT_FAILED="1"
UNMOUNT_SUCCESS="0"
VAR_MOUNTPOINT_UNDEFINED="2"
VAR_SHARE_NAME_UNDEFINED="3"

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"

## Exit if $MOUNTPOINT is not set
if [ -z "$MOUNTPOINT" ]; then
    echo "\n$($CURRENT_DATE): The shell ran into an error - The mountpoint variable was not set (line 11) in the user-defined variables.\n$($CURRENT_DATE): Abort."
    exit $VAR_MOUNTPOINT_UNDEFINED
fi

## Exit if $SHARE_NAME is not set
if [ -z "$SHARE_NAME" ]; then
    echo "\n$($CURRENT_DATE): The shell ran into an error - The share name variable was not set (line 12) in the user-defined variables.\n$($CURRENT_DATE): Abort."
    exit $VAR_SHARE_NAME_UNDEFINED
fi

## Unmounting SSHFS using specified parameters ##
echo "\n$($CURRENT_DATE): Administrative privileges are required to run this shell."
$SUDO $UMOUNT "$MOUNTPOINT" > /dev/null 2>&1

## Exit with correct code ##
if [ $? = 0 ]; then
  echo "\n$($CURRENT_DATE): Successfully unmounted $SHARE_NAME.\n$($CURRENT_DATE): Exiting.\n"
  exit $UNMOUNT_SUCCESS

else
  echo "\n$($CURRENT_DATE): The shell ran into an error.\n\n$($CURRENT_DATE): Abort.\n"
  exit $UNMOUNT_FAILED
fi
