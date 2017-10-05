#!/bin/bash

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Oracle Java 8"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

install_apt_pkg "oracle-java8-installer oracle-java8-set-default" "ppa:webupd8team/java"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
