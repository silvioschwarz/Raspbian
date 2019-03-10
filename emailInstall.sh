#! /bin/sh

echo "MX-Eintrag beim Provider einrichten"

echo "enable modules"
sudo modprobe ipv6
sudo mkdir -p /etc/citadel/netconfigs/7

echo "install citadel"
sudo apt-get update 
sudo apt-get install citadel-suite

sudo /usr/lib/citadel-server/setup

echo "
Mailserver administrieren
Geben Sie als IMAP-Servernamen die lokale IP-Adresse des Raspberry Pi und den Port 143 an, als Benutzernamen und Passwort verwenden Sie die Zugangsdaten, die Sie in Citadel festgelegt haben. Der SMTP-Server hat die gleiche IP-Adresse und nutzt auch die gleichen Zugangsdaten.
"
#	dovecot postfix
