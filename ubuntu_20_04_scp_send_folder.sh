#!/bin/sh
### Written by Lemon Tree on 04/12/2020 ###
### This shell allows an user to dynamically send a folder from a remote ssh server. A pre-configured sh configuration in /etc/ssh/ssh_config must exist for this to work ###

# Exit codes definition
EXIT_USER_CONFIRMED_ALL_DIALOGS="0"                 # User confirmed all dialogs (variable not empty)
EXIT_USER_CANCELLED_1ST_DIALOG="1"                  # User cancelled the 1st dialog - ssh configuration name
EXIT_USER_CANCELLED_2ND_DIALOG="2"                  # User cancelled the 2nd dialog - folder to send
EXIT_USER_CANCELLED_3RD_DIALOG="3"                  # User cancelled the 3rd dialog - remote destination

# User-defined variables
SCP_TIMEOUT="10"                                    # Setting a connection timeout for the $SCP transfer
#DEFAULT_CONFIGURATION="your-ssh-configuration"     # Setting your default ssh configuration

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

read -p "Please enter an existing SSH configuration name: " SSH_CONFIGURATION                                                                                # Prompt user to enter a ssh configuration name

# Continuing only if user chose to continue (OK button or enter)
if [ -z "$SSH_CONFIGURATION" ]; then
  echo "\n$($CURRENT_DATE): The script was cancelled by the user when prompting for the ssh configuration name.\n\n$($CURRENT_DATE): Exiting.\n"
  exit 1
else
  echo "\n$($CURRENT_DATE): The path of your home folder is:\n$HOMEFOLDER_FILEPATH\n"
  read -p "Please enter the path of the folder that you want to send: " FOLDER_TO_SEND                                                                       # Prompt user to enter local folderpath

  # Continuing only if user chose to continue (OK button or enter)
  if [ -z "$FOLDER_TO_SEND" ]; then
    echo "\n$($CURRENT_DATE): The script was cancelled by the user when prompting for the folder to send.\n\n$($CURRENT_DATE): Exiting.\n"
    exit 2
  else
    echo " "
    read -p "Please enter the exact path to the folder (on the remote device) to copy the files to: " REMOTE_FILEPATH                                        # Prompt user to enter remote filepath

    # Continuing only if user chose to continue (OK button or enter)
    if [ -z "$REMOTE_FILEPATH" ]; then
      echo "\n$($CURRENT_DATE): The script was cancelled by the user when prompting for the remote destination.\n\n$($CURRENT_DATE): Exiting.\n"
      exit 3
    else

      echo "\n$($CURRENT_DATE): Starting file transfer over SCP.\n"
      # Start file transfer over $SCP to $REMOTE_HOST using $SSH_CONFIGURATION
      $SCP -o ConnectTimeout="$SCP_TIMEOUT" -r "$FOLDER_TO_SEND" "$SSH_CONFIGURATION":"$REMOTE_FILEPATH"

      # Sending confimation message to user
      echo "\n$($CURRENT_DATE): The file transfer operation has finished.\nInput folder: $FOLDER_TO_SEND\nOutput folder: $REMOTE_FILEPATH\nSSH configuration name: $SSH_CONFIGURATION"
      echo "\n$($CURRENT_DATE): Exiting.\n"
    fi
  fi
fi

exit 0
