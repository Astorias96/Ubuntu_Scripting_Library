#!/bin/sh
############################################################################################################
##                              Written by Lemon Tree on 20/08/2021                                       ##
#          This shell enables and configures logging on the running NextCloud instance using OCC           #
##  Source: https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/occ_command.html   ##
############################################################################################################

# Exit codes definition
SUCCESS="0"                                                                                                # The shell ran without execution errors.
PHP_COMMAND_FAILED="1"                                                                                     # The PHP command(s) has failed to execute. Check the console logs for further information.
PHP_NOT_INSTALLED="2"                                                                                      # PHP or NextCloud is not installed correctly.

## System variables ##
DATE=$(which "date")
OCC="/var/www/nextcloud/occ"                                                                               # Set the path to the build-in Nextcloud OCC binary. Default is: /var/www/nextcloud/occ.
PHP=$(which "php")
SUDO=$(which "sudo")

## User-defined variables ##
LOG_PATH=""                                                                                                # Set a custom path for the log file. Default is: /var/www/nextcloud/data/nextcloud.log.
ROTATE_SIZE="5242880"                                                                                      # Set the maximum size of the log file before oldest entries get deleted. This entry corresponds to 5MB.
WEB_USER="www-data"                                                                                        # Set the username of your web user. On Debian, default is www-data.

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "$($CURRENT_DATE): The NextCloud (NC) logging configuration shell has started."

## If PHP is not installed, abort. ##
if [ ! -f $PHP ]; then
  echo "\n$($CURRENT_DATE): The shell has not found any PHP binary on this device. Is NextCloud installed and configured ?\n\n$($CURRENT_DATE): Abort.\n"
  exit $PHP_NOT_INSTALLED
fi

echo "\n$($CURRENT_DATE): Administrative privileges are required to run this shell."

## Enable logging ##
$SUDO -u $WEB_USER $PHP $OCC log:file --enable &&

## Configure log path ##
$SUDO -u $WEB_USER $PHP $OCC log:file --file $LOG_PATH &&

## Configure log rotation ##
$SUDO -u $WEB_USER $PHP $OCC log:file --rotate-size $ROTATE_SIZE &&

## Exiting with correct code ##
if [ $? -eq 0 ]; then
  ## Success ##
  echo "\n$($CURRENT_DATE): The shell has enabled & configured the logfile on the NC instance.\n\n$($CURRENT_DATE): Exiting.\n"
  exit $SUCCESS
else
  ## Fail ##
  echo "\n$($CURRENT_DATE): The shell has encountered an error in enabling & configuring the logging system on the NC instance.\n\n$($CURRENT_DATE): Abort.\n"
  exit $PHP_COMMAND_FAILED
fi
