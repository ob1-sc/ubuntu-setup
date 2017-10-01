#!/bin/sh

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Google Chrome"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_deb_pkg "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
