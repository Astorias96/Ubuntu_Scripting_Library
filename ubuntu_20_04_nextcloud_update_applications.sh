#!/bin/sh
############################################################################################################
##                              Written by Lemon Tree on 19/08/2021                                       ##
## This shell starts all application updates on the existing (and specified) NextCloud instance using OCC ##
############################################################################################################

# Exit codes definition
SUCCESS="0"                                                                                               # The shell ran without execution errors.
PHP_COMMAND_FAILED="1"                                                                                    # The PHP update command has failed to execute. Check the console logs for further information.
PHP_NOT_INSTALLED="2"                                                                                     # PHP or NextCloud is not installed correctly.

## System variables ##
DATE=$(which "date")
OCC="/var/www/nextcloud/occ"                                                                         # Set the path to the build-in Nextcloud OCC binary. Default is: /var/www/nextcloud/occ.
SUDO=$(which "sudo")

## User-defined variables ##
MEMORY_LIMIT="1024M"                                                                                      # Maximum allocated memory size for the update process
WEB_USER="www-data"                                                                                       # Web user to execute the update operations

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "$($CURRENT_DATE): The NextCloud (NC) applications update shell has started."

## If PHP is not installed, abort. ##
if [ ! -f $PHP ]; then
  echo "\n$($CURRENT_DATE): The shell has not found any PHP binary on this device. Is NextCloud installed and configured ?\n\n$($CURRENT_DATE): Abort.\n"
  exit $PHP_NOT_INSTALLED
fi

## Starting all application updates ##
echo "\n$($CURRENT_DATE): Administrative privileges are required to run this shell."
$SUDO -u $WEB_USER $PHP -d memory_limit=$MEMORY_LIMIT $OCC app:update --all &&

## Exiting with correct code ##
if [ $? -eq 0 ]; then
  ## Success ##
  echo "\n$($CURRENT_DATE): The shell has started the app updates on the NC instance.\n\n$($CURRENT_DATE): Exiting.\n"
  exit $SUCCESS
else
  ## Fail ##
  echo "\n$($CURRENT_DATE): The shell has encountered an error in starting the app updates on the NC instance.\n\n$($CURRENT_DATE): Abort.\n"
  exit $PHP_COMMAND_FAILED
fi
