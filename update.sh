#!/bin/sh

echo "${BLUE}UPDATING; UPGRADING AND CLEANING"
echo
echo "################################"

. "$(dirname "$0")"/shellColors.sh



echo -n "${RED}UPDATING AND UPGRADING"
echo "${NORMAL}"
echo


sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

echo -n "${GREEN}THEM PIP'ERS"

echo "${NORMAL}"
echo
#pip list --format=freeze --outdated | awk '{ print $1}' | xargs -n1 pip install -U
#pip list --format legacy --outdated | sed 's/(.*//g' | xargs -n1 sudo -H pip install -U	
#sudo -H pip install -U `pip list --format=columns --outdated | awk '!/Package|---/{ print $1}'`

sudo -H pip3 install -U `sudo pip3 list --format=columns --outdated --no-cache-dir | awk '!/Package|---/{ print $1}'`

echo -n "${RED}CLEANING"
echo "${NORMAL}"
echo

sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo apt-get -y clean
sudo apt-get -y install -f


sudo dpkg --configure -a > /dev/null

echo -n "${BLUE}DONE!"
echo "${NORMAL}"
echo



