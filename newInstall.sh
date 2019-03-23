#!/bin/sh

###########################################################################
## Change keyboard layout                                                ##
###########################################################################

if [ ! $(cat /etc/default/keyboard | egrep "^XKBLAYOUT=\"gb\"" >/dev/null) ]; then
  echo
  echo "------------------------------------------------------"
  echo "Change keyboard layout"
  echo "------------------------------------------------------"

  sudo sed -i 's/XKBLAYOUT=\"gb\"/XKBLAYOUT=\"de\"/g' /etc/default/keyboard
  sudo sed -i 's/XKBOPTIONS=\"\"/XKBOPTIONS=\"terminate:ctrl_alt_bksp\"/g' /etc/default/keyboard
  sudo invoke-rc.d keyboard-setup start

  echo
  echo "Done"
fi

###########################################################################
## Change system locales                                                 ##
###########################################################################

if [ ! $(cat /etc/locale.gen | egrep "^# de_DE.UTF-8 UTF-8" >/dev/null) ]; then
  echo
  echo "------------------------------------------------------"
  echo "Change system locales"
  echo "------------------------------------------------------"

  sudo sed -i 's/^# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen
  sudo locale-gen

  echo
  echo "Done"
fi

###########################################################################
## Change default locale                                                 ##
###########################################################################

if [ ! $(cat /etc/default/locale | egrep "^LANG=en_GB.UTF-8" >/dev/null) ]; then
  echo
  echo "------------------------------------------------------"
  echo "Change default locale"
  echo "------------------------------------------------------"

  sudo update-locale LANG=de_DE.UTF-8

  echo
  echo "Done"
fi

###########################################################################
## Change system timezone                                                ##
###########################################################################

if [ ! $(cat /etc/timezone | egrep "^Etc/UTC" >/dev/null) ]; then
  echo
  echo "------------------------------------------------------"
  echo "Change system timezone"
  echo "------------------------------------------------------"

  sudo sed -i 's/Etc\/UTC/Europe\/Berlin/g' /etc/timezone
  sudo cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime

  echo
  echo "Done"
fi

curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered | bash

sudo systemctl enable vncserver-virtuald.service
sudo systemctl enable vncserver-x11-serviced.service

sudo apt-get install -y mlocate build-essential libssl-dev libffi-dev libxml2-dev libxslt-dev libatlas-dev liblapack-dev libsuitesparse-dev libjpeg-dev zlib1g-dev libglib2.0-dev libgirepository1.0-dev libcairo2-dev libjpeg-dev libgif-dev libsdl1.2-dev libhdf5-dev

./update.sh
sudo raspi-config
