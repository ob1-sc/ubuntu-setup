#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing PyCharm Community"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_snap_pkg "pycharm-community" "true"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
