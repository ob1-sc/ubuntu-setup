#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing xclip"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_apt_pkg "xclip"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
