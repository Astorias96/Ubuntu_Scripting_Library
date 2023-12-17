#!/bin/sh
### Last modified on 31/12/2020 by Lemon Tree ###
### This shell allows an user to dynamically backup the IT configuration to a ZIP archive. ###

### System variables ###
DATE=$(which "date")
WHOAMI=$(which "whoami")
ZIP=$(which "zip")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

## Determine the logged-in user and home folder filepath, creating variables ##
CURRENT_USER=$($WHOAMI)
HOMEFOLDER_FILEPATH="/home/$CURRENT_USER"
echo "\n$($CURRENT_DATE): The current logged-in user is $CURRENT_USER. The backup shell will use $CURRENT_USER's home profile to construct the backup paths."

### User-defined variables ###
BCK_PATH1="/etc/ssh/ssh_config"
BCK_PATH2="/etc/ssh/sshd_config"
BCK_PATH3="/etc/apache2/apache2.conf"
BCK_PATH4="/etc/php/7.4/apache2/php.ini"
BCK_PATH5="$HOMEFOLDER_FILEPATH/.ssh"
BCK_PATH6="/var/www"
BCK_PATH7="/etc/fstab"
BCK_PATH8="$HOMEFOLDER_FILEPATH/scripts"
BCK_PATH9="/etc/apache2/sites-available/000-default.conf"

### Determining where to save the backup ###
echo "This shell will create a ZIP file containing the following files:\n\n$BCK_PATH1\n$BCK_PATH2\n$BCK_PATH3\n$BCK_PATH4\n$BCK_PATH5\n$BCK_PATH6\n$BCK_PATH7\n$BCK_PATH8\n$BCK_PATH9\n\nYour home directory path is: $HOMEFOLDER_FILEPATH\n"
read -p "Please enter the full path to the destination folder: " SELECTED_FOLDER

### Creating backup ZIP archive ###
echo "\n$($CURRENT_DATE): Beginning to archive...\n"
$ZIP -r $SELECTED_FOLDER/backup_IT_conf_${CURRENT_USER}_${CURRENT_DATE}.zip "$BCK_PATH1" "$BCK_PATH2" "$BCK_PATH3" "$BCK_PATH4" "$BCK_PATH5" "$BCK_PATH6" "$BCK_PATH7
" "$BCK_PATH8" "$BCK_PATH9"
#$ZIP -r backup.zip ${BACKUP_PATHS[@]}

### Exiting ##
echo "\n$($CURRENT_DATE): The backup shell has finished running.\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
