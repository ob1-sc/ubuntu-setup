#!/bin/sh

. ../common.sh

# Description of install script
HEADER_DESCRIPTION="Installing IntelliJ"

# Print the install script description header
print_header "$HEADER_DESCRIPTION"

#============ Install Script Steps ============

# Prompt for tar address
while true; do
	read -p "Please enter URL for tar download: " URL
	break
done

# install the package
install_tar_pkg intellij-idea-ce $URL

# create a sym link
sudo ln -s -f -v $INSTALL_FOLDER/bin/idea.sh /usr/bin/idea

# add desktop entry
create_launcher "IntelliJ IDEA CE" "$INSTALL_FOLDER/bin/idea.sh %f" "$INSTALL_FOLDER/bin/idea.png" "Application" "Development;"

#==============================================

# Pring the install script footer
print_footer $HEADER_TEXT_LENGTH

exit
