#!/bin/sh
### Written by Lemon Tree on 28-12-2020 ###
### This shell installs all the useful Gnome extensions for Ubuntu 20.04 ###

### System variables ###
APT_GET=$(which "apt-get")
DATE=$(which "date")
SUDO=$(which "sudo")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### Updating packages repositories ###
echo "\n$($CURRENT_DATE): Updating package repositories...\n"
$SUDO $APT_GET update ;

### Installing extension packages ###
echo "\n$($CURRENT_DATE): Beginning packages installation...\n"
$SUDO $APT_GET install variety -y ; $SUDO $APT_GET install gnome-shell-extension-xrdesktop -y ; $SUDO $APT_GET install gnome-shell-extension-workspaces-to-dock -y ; $SUDO $APT_GET install gnome-shell-extension-ubuntu-dock -y ; $SUDO $APT_GET install gnome-shell-extension-trash -y ; $SUDO $APT_GET install gnome-shell-extension-system-monitor -y ; $SUDO $APT_GET install gnome-shell-extension-suspend-button -y ; $SUDO $APT_GET install gnome-shell-extension-show-ip -y ; $SUDO $APT_GET install gnome-shell-extension-prefs -y ; $SUDO $APT_GET install gnome-shell-extension-redshift -y ; $SUDO $APT_GET install gnome-shell-extension-pixelsaver -y ; $SUDO $APT_GET install gnome-shell-extension-onboard -y ; $SUDO $APT_GET install gnome-shell-extension-no-annoyance -y ; $SUDO $APT_GET install gnome-shell-extension-multi-monitors -y ; $SUDO $APT_GET install gnome-shell-extension-weather -y ; $SUDO $APT_GET install gnome-shell-extension-move-clock -y ; $SUDO $APT_GET install gnome-shell-extension-logout-out-button -y ; $SUDO $APT_GET install gnome-shell-extension-kimpanel -y ; $SUDO $APT_GET install gnome-shell-extension-impatience -y ; $SUDO $APT_GET install gnome-shell-extension-hard-disk-led -y ; $SUDO $APT_GET install gnome-shell-extension-gsconnect-browsers -y ; $SUDO $APT_GET install gnome-shell-extension-gsconnect -y ; $SUDO $APT_GET install gnome-shell-extension-draw-on-your-screen -y ; $SUDO $APT_GET install gnome-shell-extension-disconnect-wifi -y ; $SUDO $APT_GET install gnome-shell-extension-desktop-icons -y ; $SUDO $APT_GET install gnome-shell-extension-dash-to-panel -y ; $SUDO $APT_GET install gnome-shell-extension-caffeine -y ; $SUDO $APT_GET install gnome-shell-extension-bluetooth-quick-connect -y ; $SUDO $APT_GET install gnome-shell-extension-arc-menu -y ; $SUDO $APT_GET install gnome-shell-extension-appindicator -y ; $SUDO $APT_GET install gnome-shell-extension-hide-activities -y ; $SUDO $APT_GET install gnome-shell-extension-hide-veth -y

### Exiting ###
echo "\n$($CURRENT_DATE): The gnome extensions installation process has finished running. Please check the logs for results.\n\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
