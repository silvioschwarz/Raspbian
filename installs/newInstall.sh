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

git config --global user.name "Silvio Schwarz"
git config --global user.email admin@silvioschwarz.xyz

sudo apt update
sudo apt upgrade -y

sudo raspi-config
