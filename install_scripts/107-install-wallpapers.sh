#!/bin/sh

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Ubuntu Wallpapers"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

sudo apt-get install ubuntu-wallpapers*

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
