#!/bin/sh
### Written by Lemon Tree on 10.12.2020 ###
### This shell verifies the Radeon HD 7970-8970 graphic drivers installation status on Ubuntu 20.04 ###
### https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html ###

### System variables ###
DATE=$(which "date")

### Creating $CURRENT_DATE variable ###
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

### If this command gives has an output with no errors, the driver is successfully installed and configured  ###
echo "\n$($CURRENT_DATE): If this command returns an output without errors, the driver is successfully installed and configured."

/opt/rocm/bin/rocminfo
/opt/rocm/opencl/bin/clinfo

### Exiting ###
echo "\n$($CURRENT_DATE): The shell has finished running.\n\n$($CURRENT_DATE): Exiting.\n"
exit 0
