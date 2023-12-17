#!/bin/sh
############################################################################################################################
##                                      Written by Lemon Tree on 20/08/2021                                               ##
#          This shell forces file scan, cleanup and trashes all bins on the running NextCloud instance using OCC           #
##         Source: https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/occ_command.html            ##
############################################################################################################################

# Exit codes definition
SUCCESS="0"                                                                                                                # The shell ran without execution errors.
PHP_COMMAND_FAILED="1"                                                                                                     # The PHP update command has failed to execute. Check the console logs for further information.
PHP_NOT_INSTALLED="2"                                                                                                      # PHP or NextCloud is not installed correctly.

## System variables ##
DATE=$(which "date")
OCC="/var/www/nextcloud/occ"                                                                                               # Set the path to the build-in Nextcloud OCC binary. Default is: /var/www/nextcloud/occ.
PHP=$(which "php")
SUDO=$(which "sudo")

## User-defined variables ##
WEB_USER="www-data"                                                                                                        # Set the username of your web user. On Debian, default is www-data.

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "$($CURRENT_DATE): The NextCloud (NC) file scan & cleanup shell has started."

## If PHP is not installed, abort. ##
if [ ! -f $PHP ]; then
  echo "\n$($CURRENT_DATE): The shell has not found any PHP binary on this device. Is NextCloud installed and configured ?\n\n$($CURRENT_DATE): Abort.\n"
  exit $PHP_NOT_INSTALLED
fi

echo "\n$($CURRENT_DATE): Administrative privileges are required to run this shell."

## Force re-scan all files in NextCloud ##
$SUDO -u $WEB_USER $PHP $OCC files:scan --all #--quiet

## Tidies up the server’s file cache by deleting all file entries that have no matching entries in the storage table ##
$SUDO -u $WEB_USER $PHP $OCC files:cleanup

## Remove the deleted files of all users ##
$SUDO -u $WEB_USER $PHP $OCC trashbin:cleanup --all-users

## Exit ##
exit $SUCCESS
