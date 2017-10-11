#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Ubuntu Wallpapers"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_apt_pkg "ubuntu-wallpapers*"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
