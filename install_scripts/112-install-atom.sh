#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Atom"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_deb_pkg "https://atom.io/download/deb"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
