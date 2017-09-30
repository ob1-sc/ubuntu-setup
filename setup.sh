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

install_deb_pkg() {

	local DEB_PKG_URL="$1"
	local DESC="$2"
	local FILE_NAME=package.deb

	local CMD="wget $DEB_PKG_URL -O $FILE_NAME && sudo gdebi $FILE_NAME -n && rm -f -v $FILE_NAME"

	run_cmd "$CMD" "$DESC"
}

install_snap_pkg() {

	local SNAP_PKG="$1"
	local DESC="$2"

	local CMD="sudo snap install $SNAP_PKG"
	
	run_cmd "$CMD" "$DESC"
}

install_apt_pkg() {

	local APT_PKG="$1"
	local DESC="$2"
	local APT_REPO="$3"

	local CMD="sudo apt-get install $APT_PKG -y"

	if [ ! -z $APT_REPO ]; then
		CMD="sudo add-apt-repository $APT_REPO -y -u && $CMD"
	fi

	run_cmd "$CMD" "$DESC"
}

# ensure the apt cache is up to date
run_cmd "sudo apt-get update" "updating apt cache"

# Oracle JDK8 (jdk&jre)
install_apt_pkg "oracle-java8-installer oracle-java8-set-default" "installing Oracle Java 8" "ppa:webupd8team/java"

# install gdebi - simple tool to install deb files.
install_apt_pkg "gdebi" "installing gdebi"

# install tbux & byobu (great terminal combination)
install_apt_pkg "tmux byobu" "installing byobu & tmux"

# install google chrome
install_deb_pkg "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" "installing google chrome"

# install slack
install_deb_pkg "https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.0-amd64.deb" "installing slack"

# simplenote 
install_snap_pkg "simplenote" "installing simplenote"

# Remmina
install_apt_pkg "remmina remmina-plugin-rdp libfreerdp-plugins-standard" "install remmina" "ppa:remmina-ppa-team/remmina-next"

# Remarkable
install_deb_pkg "http://remarkableapp.github.io/files/remarkable_1.87_all.deb" "installing remarkable"

# ensure packages are up to date
run_cmd "sudo apt-get update && sudo apt-get upgrade -y" "ensuring all packages are up to date"

# clean up
run_cmd "sudo apt-get autoremove" "cleaning up"

exit

# Postman

# IntelliJ

# Docker CE

# Docker Compose
