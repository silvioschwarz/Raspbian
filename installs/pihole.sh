#! /bin/sh

curl -sSL https://install.pi-hole.net | bash

sudo apt install unbound

wget -O root.hints https://www.internic.net/domain/named.root
sudo cp root.hints /var/lib/unbound/
sudo cp ../configs/pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf

sudo service unbound start
dig pi-hole.net @127.0.0.1 -p 5335

#sudo ./firewallInstall.sh

