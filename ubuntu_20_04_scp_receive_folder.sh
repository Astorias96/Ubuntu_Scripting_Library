#!/bin/sh
### Written by Lemon Tree on 04/12/2020 ###
### This shell allows an user to dynamically receive a folder from a remote ssh server. A pre-configured sh configuration in /etc/ssh/ssh_config must exist for this to work ###

# Exit codes definition
EXIT_USER_CONFIRMED_ALL_DIALOGS="0"                 # User confirmed all dialogs (variable not empty)
EXIT_USER_CANCELLED_1ST_DIALOG="1"                  # User cancelled the 1st dialog - ssh configuration name
EXIT_USER_CANCELLED_2ND_DIALOG="2"                  # User cancelled the 2nd dialog - local destination
EXIT_USER_CANCELLED_3RD_DIALOG="3"                  # User cancelled the 3rd dialog - folder to receive (remote)

# User-defined variables
SCP_TIMEOUT="10"                                    # Setting a connection timeout for the $SCP transfer

# Declare command variables
CUT=$(which "cut")
DATE=$(which "date")
SCP=$(which "scp")
SORT=$(which "sort")
UNIQ=$(which "uniq")
WHO=$(which "who")

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

## Determine the logged-in user and home folder filepath, creating variables ##
CURRENT_USER=$($WHO | $CUT -d' ' -f1 | $SORT | $UNIQ)
HOMEFOLDER_FILEPATH="/home/$CURRENT_USER"

# Declare READ commands variables,

read -p "Please enter an existing SSH configuration name: " SSH_CONFIGURATION                                                                                           # Prompt user to enter a ssh configuration name

# Continuing only if user chose to continue (OK button or enter)
if [ -z "$SSH_CONFIGURATION" ]; then
  echo "\n$($CURRENT_DATE): The script was cancelled by the user when prompting for the ssh configuration name.\n\n$($CURRENT_DATE): Exiting.\n"
  exit 1
else
  echo "\n$($CURRENT_DATE): The path of your home folder is:\n$HOMEFOLDER_FILEPATH\n"
  read -p "Please enter the path where the folder should be copied: " LOCAL_FILEPATH                                                                                    # Prompt user to enter local filepath

  # Continuing only if user chose to continue (OK button or enter)
  if [ -z "$LOCAL_FILEPATH" ]; then
    echo "\n$($CURRENT_DATE): The script was cancelled by the user when prompting for the local destination.\n\n$($CURRENT_DATE): Exiting.\n"
    exit 2
  else
    echo " "
    read -p "Please enter the exact path of the folder (on the remote device) that you want to receive: " FOLDER_TO_RECEIVE                                             # Prompt user to enter remote folderpath

    # Continuing only if user chose to continue (OK button or enter)
    if [ -z "$FOLDER_TO_RECEIVE" ]; then
      echo "\n$($CURRENT_DATE): The script was cancelled by the user when prompting for the folder to receive.\n\n$($CURRENT_DATE): Exiting.\n"
      exit 3
    else

      echo "\n$($CURRENT_DATE): Starting file transfer over SCP.\n"
      # Start file transfer over $SCP to $LOCAL_HOST using $SSH_CONFIGURATION
      $SCP -o ConnectTimeout="$SCP_TIMEOUT" -r "$SSH_CONFIGURATION":"$FOLDER_TO_RECEIVE" "$LOCAL_FILEPATH"

      # Sending confimation message to user
      echo "\n$($CURRENT_DATE): The file transfer operation has finished.\nInput folder: $FOLDER_TO_RECEIVE\nOutput folder: $LOCAL_FILEPATH\nSSH configuration name: $SSH_CONFIGURATION"
      echo "\n$($CURRENT_DATE): Exiting.\n"
    fi
  fi
fi

exit 0
