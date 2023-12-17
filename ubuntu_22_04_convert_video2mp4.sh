#!/bin/sh
### Written by Lemon Tree on 28/12/2020 ###
### This shell allows an user to dynamically convert a video files from a specified folder to MPEG-4 format. This allows to save a lot of disk space without loosing the video quality. ###

### Command variables ###
APT_GET=$(which "apt-get")
DATE=$(which "date")
LS=$(which "ls")
RM=$(which "rm")
SUDO=$(which "sudo")
WHOAMI=$(which "whoami")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

## Determine the logged-in user and home folder filepath, creating variables ##
CURRENT_USER=$($WHOAMI)
HOMEFOLDER_FILEPATH="/home/$CURRENT_USER"

### Checking if ffmpeg is installed ###
FFMPEG=$(which "ffmpeg")
if [ $? != 0 ]; then
  ### Install ffmpeg if missing ###
  echo "\n$($CURRENT_DATE): This shell will begin the installation of the FFMPEG binaries, as they are not present on this device. In the next step, you will get prompted for your password.\n"
  $SUDO $APT_GET update &&
  $SUDO $APT_GET install "ffmpeg"

fi

### Continue execution. Selecting input folder ###
echo "\n$($CURRENT_DATE): The selected folder will be scanned for video files. All files that are found will be converted into MPEG-4 format.\nFolder example: $HOMEFOLDER_FILEPATH/videos\n"
read -p "Please enter the full path to the input folder: " SELECTED_FOLDER

### Declaring function ###
VideoIsConvertible() {
  [ "${1##*.}" = "avi" ] || [ "${1##*.}" = "mkv" ] || [ "${1##*.}" = "mov" ] || [ "${1##*.}" = "wmv" ]
  return $?
}

if [ ! -z "$SELECTED_FOLDER" ] || [ -d "$SELECTED_FOLDER" ]; then
  ### Creating a loop to convert all video files in the specified folder to MPEG-4 video files ###
    for i in "$SELECTED_FOLDER"/*; do
      if VideoIsConvertible "$i" ; then
        echo "\n$($CURRENT_DATE): Starting conversion process for the video file \"$i\"." &&
        $FFMPEG -i "$i" "${i%.*}.mp4" > /dev/null 2>&1
        if [ $? = 0 ]; then
          $RM -f "$i"
          echo "\n$($CURRENT_DATE): The video file \"$i\" was sucessfully converted into MPEG-4 format. The input file was deleted."
        else
          echo "\n$($CURRENT_DATE): Error while converting the video file \"$i\"."
        fi
      fi
    done

  ### Informing user after the conversion ###
  echo "\n$($CURRENT_DATE): The conversion process for the video files in \"$SELECTED_FOLDER\" has finished. Check the log to confirm the file were converted into MPEG-4 video files.\n"

  ### Exiting ###
  echo "\n$($CURRENT_DATE): Exiting.\n"
  exit 0

else
  echo "$($CURRENT_DATE): The script was cancelled by the user when selecting the input folder or the input folder does not exist.\n\n$($CURRENT_DATE): Exiting.\n"
  exit 1
fi
