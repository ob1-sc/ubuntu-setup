#!/bin/sh

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Slack"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_deb_pkg "https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.0-amd64.deb" 

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
