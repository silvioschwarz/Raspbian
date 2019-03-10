#! /bin/sh

echo "install polipo proxy"
sudo apt-get install polipo ana cron

sudo nano /etc/polipo/config

#proxyAddress = "192.168.1.33"
#allowedClients = 127.0.0.1, 192.168.1.0/24
sudo service polipo restart

sudo update-rc.d polipo defaults

