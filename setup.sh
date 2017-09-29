#!/bin/sh

print_header() {

	HEADER_TEXT="======= $1 ======="

	echo $HEADER_TEXT | tr "[:print:]" =
	echo $HEADER_TEXT
	echo $HEADER_TEXT | tr "[:print:]" =

	exit
}

print_header "updating apt cache"
sudo apt-get update

# gdebi - simple tool to install deb files.
# It lets you install local deb packages resolving and installing its dependencies.
sudo apt-get install gdebi -y

# simplenote 
sudo snap install simplenote

# tbux & byobu (great terminal combination)
sudo apt-get install tmux byobu -y

# google chrome

# slack
FILE_SLACK=slack-desktop-2.8.0-amd64.deb
wget https://downloads.slack-edge.com/linux_releases/$FILE_SLACK
sudo gdebi $FILE_SLACK -n
rm -f -v $FILE_SLACK

# Oracle JDK8 (jdk&jre)

# Postman

# IntelliJ

# Docker CE

# Docker Compose

# Remmina

# Remarkable
