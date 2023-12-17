#!/bin/sh
### Written by Lemon Tree on 29-12-2020 ###
### This shell installs the latest samba server version for Ubuntu 20.04 ###

### System variables ###
APT_GET=$(which "apt-get")
CP=$(which "cp")
DATE=$(which "date")
SUDO=$(which "sudo")
WHOAMI=$(which "whoami")

### User-defined variable ###

SMB_CONFIG="/etc/samba/smb.conf"
SMB_CONFIG_BCK_PATH="/etc/samba/smb.conf_backup"

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### Get current logged-in user ###
CURRENT_USER=$($WHOAMI)

### Install tasksel (pre-requisite) ###
$SUDO $APT_GET install "tasksel" -y
if [ $? = 0 ]; then
  echo "\n$($CURRENT_DATE): The installation process for tasksel has completed."
  ### Declaring tasksel system variable ###
  TASKSEL=$(which "tasksel")

  ### Install samba-server ###
  $SUDO $TASKSEL install "samba-server"
  if [ $? = 0 ]; then
    echo "\n$($CURRENT_DATE): The installation process for samba-server has completed."

    ### Declaring smbpasswd system variable ###
    SMBPASSWD=$(which "smbpasswd")

    ### Create samba server default configuration backup ###
    echo "\n$($CURRENT_DATE): Creating the samba-server configuration file backup. It is located there:\n$SMB_CONFIG_BCK_PATH"
    $SUDO $CP "$SMB_CONFIG" "$SMB_CONFIG_BCK_PATH"

    ### Create samba user (linked to current system user) ###
    echo "\n$($CURRENT_DATE): In the next step, you will be guided to create a new samba user.\n$($CURRENT_DATE): The username '$CURRENT_USER' will be used but you will need to enter a password manually (it can be different than $CURRENT_USER's password)."
    $SUDO $SMBPASSWD -a $CURRENT_USER
    echo "\n$($CURRENT_DATE): The samba user creation process has finished.\n\n$($CURRENT_DATE): Please configure the samba-server configuration file depending on your needs. It is located here:\n$SMB_CONFIG\n\n\nTo share your home directory, the following template can be added to the end of the samba-server configuration file:\n\n[homes]\ncomment = Home Directories\nbrowseable = yes\nread only = no\ncreate mask = 0700\ndirectory mask = 0700\nvalid users = %S\n\n\nTo create a new share, the following template can be adapted and added to the end of the samba-server configuration file:\n\n[public]\ncomment = public anonymous access\npath = /var/samba/\nbrowsable =yes\ncreate mask = 0660\ndirectory mask = 0771\nwritable = yes\nguest ok = yes\n\n\n$($CURRENT_DATE): The samba-server installation shell has finished running.\n$($CURRENT_DATE): Exiting.\n"
    exit 0

  else
    echo "\n$($CURRENT_DATE): The samba-server installation shell has failed. The installation for the samba-server packages has failed.\n\n$($CURRENT_DATE): Exiting.\n"
    exit 2

  fi

else
  echo "\n$($CURRENT_DATE): The samba-server installation shell has failed. The installation for the tasksel packages has failed.\n\n$($CURRENT_DATE): Exiting.\n"
  exit 1

fi
