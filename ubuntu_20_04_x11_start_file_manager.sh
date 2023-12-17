#!/bin/sh
### Start defined $COMMAND and hide logs from CLI ###
### Written by Lemon Tree on 06-12-2020 ###

### System variables ###
DATE=$(which "date")

### User-defined variables ###
COMMAND="nautilus"

### Creating $CURRENT_DATE variable & informing ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started.\n\n$($CURRENT_DATE): Initiating $COMMAND..."
#stty -flusho

### Executing ###
$COMMAND & > /dev/null 2>&1
#stty flusho

### Exiting ###
echo "\n$($CURRENT_DATE): The software \"$COMMAND\" was started.\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
