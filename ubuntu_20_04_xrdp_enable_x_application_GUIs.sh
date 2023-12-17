#!/bin/sh
########################################################################################################################
##                                     Written by Lemon Tree on 12/09/2021                                            ##
##                 This shell allows a non-root user to execute X-based application GUI when on Xrdp                  ##
##                            Usage - sh ./ubuntu_20_04_xrdp_enable_x_application_GUIs.sh                             ##
##  Source - https://askubuntu.com/questions/768508/cant-launch-graphical-apps-from-terminal-after-updating-to-15-10  ##
########################################################################################################################

# Exit codes definition
SUCCESS="0"
FAILED="1"

## System variables ##
DATE=$(which "date")

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "$($CURRENT_DATE): The xRDP configuration shell has started."

## Executing Xhost command ##
xhost+

## Exiting with correct code ##
if [ $? -eq 0 ]; then
  ## Success ##
  echo "\n$($CURRENT_DATE): The shell has finished running. You can now run X-based application GUI's when on Xrdp.\n\n$($CURRENT_DATE): Exiting.\n"
  exit $SUCCESS
else
  ## Fail ##
  echo "\n$($CURRENT_DATE): The shell has encountered an error. Please see the console logs for more information.\n\n$($CURRENT_DATE): Abort.\n"
  exit $FAILED
fi
