#!/bin/sh

repeat_char() {
	
	local CHAR=$1
	local LEN=$2
	
	printf '%*s' "$LEN" | tr ' ' "$CHAR"
}

print_header() {

	local HEADER_TEXT="======= $1 ======="

	echo $HEADER_TEXT | tr "[:print:]" =
	echo $HEADER_TEXT
	echo $HEADER_TEXT | tr "[:print:]" =

	HEADER_TEXT_LENGTH=${#HEADER_TEXT}
}

print_footer() {

	repeat_char "=" $1
	printf "\n\n"
}

run_cmd() {

	local CMD="$1"
	local CMD_DESC="$2"

	HEADER_TEXT_LENGTH=0

	print_header "$CMD_DESC"
	
	eval $CMD

	print_footer $HEADER_TEXT_LENGTH

	HEADER_TEXT_LENGTH=0
}

create_launcher() {
	
	local NAME="$1"
	local EXEC="$2"
	local ICON="$3"
	local TYPE="$4"
	local CATEGORIES="$5"
	
	# create launcher file name
	# replace any whitespace with dashes and convert to lowercase
	local LAUNCHER_NAME=$(echo $NAME | tr " " - | tr '[:upper:]' '[:lower:]')
	local LAUNCHER_FILE=$LAUNCHER_NAME.desktop
	
	# add desktop entry
	touch $LAUNCHER_FILE 
	echo "[Desktop Entry]" >> $LAUNCHER_FILE 
	echo "Encoding=UTF-8" >> $LAUNCHER_FILE 
	echo "Name=$NAME" >> $LAUNCHER_FILE 
	echo "Exec=$EXEC" >> $LAUNCHER_FILE 
	echo "Icon=$ICON" >> $LAUNCHER_FILE 
	echo "Type=$TYPE" >> $LAUNCHER_FILE 
	echo "Categories=$CATEGORIES" >> $LAUNCHER_FILE 
	
	# move the launcher to applications shortcut folder
	sudo mv $LAUNCHER_FILE /usr/share/applications
}

install_tar_pkg() {

	local TAR_PKG_URL="$1"
	local FILE_NAME=package.tar.gz
	local INSTALL_DIR=/opt

	# download the tar
	wget $TAR_PKG_URL -O $FILE_NAME

	# store the current working directory
	local CWD=$(pwd) 

	# get the name of the top level folder in the tar
	local TAR_PKG_NAME=$(tar tfz $FILE_NAME --exclude '*/*')

	# move the tar to the installation directory	
	sudo mv $FILE_NAME $INSTALL_DIR
	
	# cd into the installion director
	cd $INSTALL_DIR
	
	# remove the existing folder
	sudo rm -r -f $TAR_PKG_NAME

	# unpack the war
	sudo tar -xzf $FILE_NAME

	# ensure the ownership is correctly set
	sudo chown root.root -R $TAR_PKG_NAME

	# delete the tar
	sudo rm -f -v $FILE_NAME

	# cd back to the working directory
	cd $CWD
}

install_deb_pkg() {

	local DEB_PKG_URL="$1"
	local FILE_NAME=package.deb

	# download the deb
	wget $DEB_PKG_URL -O $FILE_NAME
	
	# install the deb
	sudo gdebi $FILE_NAME -n

	# delete the deb
	rm -f -v $FILE_NAME
}

install_snap_pkg() {

	local SNAP_PKG="$1"

	# install the snap
	sudo snap install $SNAP_PKG
}

install_apt_pkg() {

	local APT_PKG="$1"
	local APT_REPO="$2"
	
	# if a repo has been provided then add it	
	if [ ! -z $APT_REPO ]; then
		sudo add-apt-repository $APT_REPO -y -u
	fi

	# install the package
	sudo apt-get install $APT_PKG -y
}
