#!/bin/sh

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing Postman"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

# install the tar
install_tar_pkg postman https://dl.pstmn.io/download/latest/linux64

# create sym link
sudo ln -s -f -v $INSTALL_FOLDER/Postman /usr/bin/postman

# add desktop entry
create_launcher "Postman" "postman --disable-gpu %f" "$INSTALL_FOLDER/resources/app/assets/icon.png" "Application" "Development;"


#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
