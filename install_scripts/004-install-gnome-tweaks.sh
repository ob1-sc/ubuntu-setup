#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Gnome Tweaks"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_apt_pkg "gnome-tweak-tool"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
