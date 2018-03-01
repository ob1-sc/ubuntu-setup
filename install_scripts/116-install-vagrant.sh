#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Vagrant"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_deb_pkg "https://releases.hashicorp.com/vagrant/2.0.2/vagrant_2.0.2_x86_64.deb"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
