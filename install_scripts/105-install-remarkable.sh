#!/bin/sh

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Remarkable"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_deb_pkg "http://remarkableapp.github.io/files/remarkable_1.87_all.deb"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
