#!/bin/sh
## Written by Lemon Tree on 05-04-2021 ##
## This shell mounts a SSHFS share using the specified parameters (in the user-defined variables). ##

## System variables ##
DATE=$(which "date")
SSHFS=$(which "sshfs")
SUDO=$(which "sudo")

## User-defined variables ##
#SSH_CONFIG="your-ssh-config-name"         # Uncomment and set your ssh config name
REMOTE_FOLDER="/"                          # Optionally, you can change the root folder of the remote ssh server that will be used for this connection
#MOUNTPOINT="/your/mount/path/"            # Uncomment and set to your mountpoint details
#SHARE_NAME="YOUR-SHARE-NAME"              # Uncomment and set to your share details

## Exit codes ##
MOUNT_FAILED="1"                           # Mount failed - Possible root cause - Verify if option 'user_allow_other' is set in /etc/fuse.conf
MOUNT_SUCCESS="0"
VAR_MOUNTPOINT_UNDEFINED="2"
VAR_SHARE_NAME_UNDEFINED="3"
VAR_SSH_CONFIG_UNDEFINED="4"

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"

## Exit if $MOUNTPOINT is not set
if [ -z "$MOUNTPOINT" ]; then
    echo "\n$($CURRENT_DATE): The shell ran into an error - The mountpoint variable was not set (line 13) in the user-defined variables.\n$($CURRENT_DATE): Abort."
    exit $VAR_MOUNTPOINT_UNDEFINED
fi

## Exit if $SHARE_NAME is not set
if [ -z "$SHARE_NAME" ]; then
    echo "\n$($CURRENT_DATE): The shell ran into an error - The share name variable was not set (line 14) in the user-defined variables.\n$($CURRENT_DATE): Abort."
    exit $VAR_SHARE_NAME_UNDEFINED
fi

## Exit if $SSH_CONFIG is not set
if [ -z "$SSH_CONFIG" ]; then
    echo "\n$($CURRENT_DATE): The shell ran into an error - The ssh config variable was not set (line 11) in the user-defined variables.\n$($CURRENT_DATE): Abort."
    exit $VAR_SSH_CONFIG_UNDEFINED
fi

## Mounting SSHFS using specified parameters ##
echo "\n$($CURRENT_DATE): SSH credentials for $SSH_CONFIG are required to run this shell.\n$($CURRENT_DATE): Mounting $SHARE_NAME using the specified SSH configuration."
$SSHFS $SSH_CONFIG:/$REMOTE_FOLDER "$MOUNTPOINT" -o allow_other -o reconnect > /dev/null 2>&1

## Exit with correct code ##
if [ $? = 0 ]; then
  echo "\n$($CURRENT_DATE): Mounted $SHARE_NAME using SSH configuration \"$SSH_CONFIG\".\n$($CURRENT_DATE): Exiting shell.\n"
  exit $MOUNT_SUCCESS

else
  echo "\n$($CURRENT_DATE): The shell ran into an error. Verify if option 'user_allow_other' is set in /etc/fuse.conf.\n\n$($CURRENT_DATE): Abort mount.\n"
  exit $MOUNT_FAILED
fi
