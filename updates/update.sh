#!/bin/sh

. "$(dirname "$0")"/shellColors.sh

echo  "${BLUE}################################"
echo  "UPDATING, UPGRADING AND CLEANING"
echo "################################"
echo
echo  "${RED}################################"
echo  "UPDATING AND UPGRADING"
echo  "################################"
echo "${NORMAL}"
echo

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

echo  "${RED}################################"
echo  "CLEANING"
echo  "################################"
echo "${NORMAL}"
echo

sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo apt-get -y clean
sudo apt-get -y install -f


sudo dpkg --configure -a > /dev/null

echo  "${BLUE}################################"
echo  "DONE!"
echo  "################################"
echo "${NORMAL}"
echo


