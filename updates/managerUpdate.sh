#!/bin/sh

. "$(dirname "$0")"/shellColors.sh

echo  "${BLUE}################################"
echo  "UPDATING, UPGRADING AND CLEANING"
echo "################################"
echo "${NORMAL}"

ROOT_UID="0"

#Check if run as root
#if [ "$UID" -ne "$ROOT_UID" ] ; then
#        echo "You must be root to do that!"
#        exit 1
#fi

snap list | awk -F" " '{if ($1 && NR>1) { system("snap refresh " $1 " 2>/dev/null") }}'

echo  "${GREEN}################################"
echo  "THEM PIP'ERS"
echo  "################################"
echo "${NORMAL}"
echo
#sudo -H pip3 install -U pip
#pip list --format legacy --outdated | awk '{ print $1}' | xargs sudo -H pip install -U --no-cache-dir --ignore-installed
#pip install -r <(pip freeze) --upgrade --no-cache-dir --user
pip3 install --user -U `pip3 list --format=columns --outdated | awk '!/Package|---/{ print $1}'`

conda update --all --override-channels -c main -c conda-forge


echo  "${GREEN}################################"
echo  "NODE 'n' NPM"
echo  "################################"
echo "${NORMAL}"
echo
npm install -g npm
rvm get stable --auto-dotfiles
apm upgrade
echo  "${BLUE}################################"
echo  "DONE!"
echo  "################################"
echo "${NORMAL}"
echo


