#!/bin/bash

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

add_app_to_favorites() {

	local APP_NAME="$1"
	local SHORTCUT_FILE="/usr/share/applications/$APP_NAME.desktop"

	# get the current array of favorites
	local FAVORITES="$(gsettings get org.gnome.shell favorite-apps)"

	# check the app shortcut is valid
	if [ -f $SHORTCUT_FILE ]
	then

		if [[ $FAVORITES != *"$APP_NAME"* ]]
		then
			echo "adding app to favourites ..."

			# strip the trailing bracket
			FAVORITES="$(echo $FAVORITES | sed 's/.$//')"

			# add the app to the array
			FAVORITES="$FAVORITES, '$APP_NAME.desktop'"

			# close the array
			FAVORITES="$FAVORITES]"

			# set the array of favorites
			gsettings set org.gnome.shell favorite-apps "$FAVORITES"
		fi

	else
		echo "cannot add app shortcut as it cannot be found"
 	fi
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

	# ensure the ownership is correctly set
	sudo chown root.root -R $LAUNCHER_FILE

	# move the launcher to applications shortcut folder
	sudo mv $LAUNCHER_FILE /usr/share/applications
}

install_tar_pkg() {

	local INSTALL_NAME="$1"
	local TAR_PKG_URL="$2"
	local FILE_NAME="$INSTALL_NAME.tar.gz"
	local INSTALL_DIR=/opt

	# download the tar
	wget $TAR_PKG_URL -O $FILE_NAME

	# store the current working directory
	local CWD=$(pwd)

	# move the tar to the installation directory
	sudo mv $FILE_NAME $INSTALL_DIR

	# cd into the installion director
	cd $INSTALL_DIR

	# remove the existing folder
	sudo rm -r -f $INSTALL_NAME

	# create folder to install into
	sudo mkdir $INSTALL_NAME

	# unpack the war
	sudo tar -xzf $FILE_NAME -C $INSTALL_NAME --strip-components=1

	# ensure the ownership is correctly set
	sudo chown root.root -R $INSTALL_NAME

	# delete the tar
	sudo rm -f -v $FILE_NAME

	# cd back to the working directory
	cd $CWD

	# set the install folder
	INSTALL_FOLDER="$INSTALL_DIR/$INSTALL_NAME"
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
	local CLASSIC_CONFINEMENT="$2"

	# build the command
	INSTALL_CMD="sudo snap install $SNAP_PKG"

	if [[ $CLASSIC_CONFINEMENT == "true" ]]; then
		INSTALL_CMD="$INSTALL_CMD --classic"
	fi

	# install the snap
	eval $INSTALL_CMD
}

add_apt_source() {

	local APT_SOURCE_URL="$1"
  local APT_SOURCE_CLASS="$2"
	local APT_KEY_URL="$3"

	# source the os-release file to get os-release variables
  . /etc/os-release

  APT_SOURCE_FILE=/etc/apt/sources.list
	APT_SOURCE="deb $APT_SOURCE_URL $VERSION_CODENAME $APT_SOURCE_CLASS"

  # if apt source isnt already set in sources
	if ! grep -q "$APT_SOURCE" "$APT_SOURCE_FILE"; then

    echo "Adding the following to $APT_SOURCE_FILE:"
		echo $APT_SOURCE

		# append the apt source
		sudo echo $APT_SOURCE >> /etc/apt/sources.list

		# download the apt public key
		local FILE_NAME=/tmp/key.asc

		# download the public key
		sudo wget $APT_KEY_URL -O $FILE_NAME

		# add the key
		sudo apt-key add $FILE_NAME

		# delete the public key
		sudo rm -f -v $FILE_NAME

   # update apt
		sudo apt-get update
	fi
}

install_apt_pkg() {

	local APT_PKG="$1"
	local APT_REPO="$2"

	# if a repo has been provided then add it
	if [ ! -z $APT_REPO ]; then
		sudo add-apt-repository $APT_REPO -y -u
		sudo apt-get update
	fi

	# install the package
	sudo apt-get install $APT_PKG -y
}
