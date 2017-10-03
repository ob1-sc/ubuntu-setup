#!/bin/sh

. ./common.sh

# ensure the apt cache is up to date
run_cmd "sudo apt-get update" "updating apt cache"

# run all the scripts in the install folder
INSTALL_SCRIPTS_DIR=./install_scripts

cd $INSTALL_SCRIPTS_DIR
chmod +x *.sh

for SCRIPT in ./*.sh
do
	if [ -f $SCRIPT -a -x $SCRIPT ]
	then
		$SCRIPT
	fi
done

cd ..

# ensure packages are up to date
run_cmd "sudo apt-get update && sudo apt-get upgrade -y" "ensuring all packages are up to date"

# clean up
run_cmd "sudo apt-get autoremove" "cleaning up"

exit

# Docker CE

# Docker Compose
