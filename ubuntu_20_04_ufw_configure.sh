#!/bin/sh
### Written by Lemon Tree on 27.02.2021 ###
### This shell is helping to configure the firewall to use http sites, samba and ssh server on this device. It blocks all other incoming connection. ###

### System variables ###
DATE=$(which "date")
SUDO=$(which "sudo")
UFW=$(which "ufw")

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The firewall rules automation shell has started."
echo "\n$($CURRENT_DATE): Administrative privileges are required to run this shell."

## Deny all incoming trafic / allow all outgoing trafic ##
echo "\n$($CURRENT_DATE): Applying default firewall configuration...\n"
$SUDO $UFW default deny incoming
$SUDO $UFW default allow outgoing

## Allow http trafic, if necessary ##
echo " "
read -p "Do you wish to create firewall rules for HTTP/HTTPS trafic ? (y/n) " RESPONSE
if [ $RESPONSE = "y" ] || [ $RESPONSE = "Y" ] || [ $RESPONSE = "yes" ] || [ $RESPONSE = "Yes" ]; then
  $SUDO $UFW allow http
  echo "\n$($CURRENT_DATE): HTTP/HTTPS rules has been configured. Continuing firewall setup...\n"
elif [ $RESPONSE = "n" ] || [ $RESPONSE = "N" ] || [ $RESPONSE = "no" ] || [ $RESPONSE = "No" ]; then
  echo "\n$($CURRENT_DATE): HTTP/HTTPS rules will not be configured. Continuing firewall setup...\n"
else
  echo "\n$($CURRENT_DATE): This option has been skipped. To apply, restart the automation shell.\n"
fi

## Allow $SSH_SERVER_PORT trafic, if necessary ##
read -p "Do you wish to create firewall rules for openSSH server on this device ? (y/n) " RESPONSE
if [ $RESPONSE = "y" ] || [ $RESPONSE = "Y" ] || [ $RESPONSE = "yes" ] || [ $RESPONSE = "Yes" ]; then
  read -p "Please enter the port from the sshd_config of this SSH server: " SSH_SERVER_PORT
  $SUDO $UFW allow $SSH_SERVER_PORT/tcp
  echo "\n$($CURRENT_DATE): SSH rules has been configured. Continuing firewall setup...\n"
elif [ $RESPONSE = "n" ] || [ $RESPONSE = "N" ] || [ $RESPONSE = "no" ] || [ $RESPONSE = "No" ]; then
  echo "\n$($CURRENT_DATE): SSH rules will not be configured. Continuing firewall setup...\n"
else
  echo "\n$($CURRENT_DATE): This option has been skipped. To apply, restart the automation shell.\n"
fi

## Allow samba trafic, if necessary ##
read -p "Do you wish to create firewall rules for samba file sharing ? (y/n) " RESPONSE
if [ $RESPONSE = "y" ] || [ $RESPONSE = "Y" ] || [ $RESPONSE = "yes" ] || [ $RESPONSE = "Yes" ]; then
  $SUDO $UFW allow out 445/tcp
  $SUDO $UFW allow out 139/tcp
  $SUDO $UFW allow out 137/udp
  $SUDO $UFW allow out 138/udp
  $SUDO $UFW allow 445/tcp
  $SUDO $UFW allow 139/tcp
  $SUDO $UFW allow 137/udp
  $SUDO $UFW allow 136/udp
  echo "\n$($CURRENT_DATE): Samba file sharing rules has been configured. Continuing firewall setup...\n"
elif [ $RESPONSE = "n" ] || [ $RESPONSE = "N" ] || [ $RESPONSE = "no" ] || [ $RESPONSE = "No" ]; then
  echo "\n$($CURRENT_DATE): Samba file sharing rules will not be configured. Continuing firewall setup...\n"
else
  echo "\n$($CURRENT_DATE): This option has been skipped. To apply, restart the automation shell.\n"
fi

## Enable firewall now, if necessary ##
read -p "Do you wish to enable firewall on this device now ? (y/n) " RESPONSE
if [ $RESPONSE = "y" ] || [ $RESPONSE = "Y" ] || [ $RESPONSE = "yes" ] || [ $RESPONSE = "Yes" ]; then
  $SUDO $UFW enable
  ## Show currently applied firewall rules ##
  echo "\n$($CURRENT_DATE): The firewall rules automation shell has finished running.\nPlease find the firewall rules that were applied to this system below:\n"
  $SUDO $UFW status
elif [ $RESPONSE = "n" ] || [ $RESPONSE = "N" ] || [ $RESPONSE = "no" ] || [ $RESPONSE = "No" ]; then
  echo "\n$($CURRENT_DATE): The firewall rules automation shell has finished running."
else
  echo "\n$($CURRENT_DATE): This option has been skipped. To apply, restart the automation shell."
fi

### Exiting ###
echo "$($CURRENT_DATE): Exiting.\n"
exit 0
