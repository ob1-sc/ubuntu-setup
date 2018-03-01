#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Abricotine"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_deb_pkg "https://github.com/brrd/Abricotine/releases/download/0.6.0/Abricotine-0.6.0-ubuntu-debian-x64.deb"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
