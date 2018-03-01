#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Virtualbox"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

add_apt_source "https://download.virtualbox.org/virtualbox/debian" "contrib" "https://www.virtualbox.org/download/oracle_vbox_2016.asc"
install_apt_pkg "virtualbox-5.2"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
