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
}

run_cmd() {

	local CMD="$1"
	local CMD_DESC="$2"

	HEADER_TEXT_LENGTH=0

	print_header "$CMD_DESC"
	
	eval $CMD

	print_footer $HEADER_TEXT_LENGTH
	printf "\n\n"

	HEADER_TEXT_LENGTH=0
}

install_deb() {

	local DEB_URL="$1"
	local DESC="$2"
	local FILE_NAME=package.deb

	local CMD="wget $DEB_URL -O $FILE_NAME && sudo gdebi $FILE_NAME -n && rm -f -v $FILE_NAME"

	run_cmd "$CMD" "$DESC"
}

install_snap() {

	local SNAP_PACKAGE="$1"
	local DESC="$2"

	local CMD="sudo snap install $SNAP_PACKAGE"
	
	run_cmd "$CMD" "$DESC"
}

# ensure the apt cache is up to date
run_cmd "sudo apt-get update" "updating apt cache"

# install gdebi - simple tool to install deb files.
run_cmd "sudo apt-get install gdebi -y" "installing gdebi"

# install tbux & byobu (great terminal combination)
run_cmd "sudo apt-get install tmux byobu" "installing byobu & tmux"

# install google chrome
install_deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" "installing google chrome"

# install slack
install_deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.0-amd64.deb" "installing slack"

# simplenote 
install_snap "simplenote" "installing simplenote"

exit


# Oracle JDK8 (jdk&jre)

# Postman

# IntelliJ

# Docker CE

# Docker Compose

# Remmina

# Remarkable
