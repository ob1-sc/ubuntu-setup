#!/bin/sh

. ./common.sh

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
