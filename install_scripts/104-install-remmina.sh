#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Remmina"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_apt_pkg "remmina remmina-plugin-rdp libfreerdp-plugins-standard" "ppa:remmina-ppa-team/remmina-next"

add_app_to_favorites "remmina"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
