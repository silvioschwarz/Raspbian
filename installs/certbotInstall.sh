#! /bin/sh

sudo apt install snapd
sudo snap install core
sudo snap refresh core

sudo apt remove certbot

sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

sudo certbot --apache
#sudo apt-get install python-certbot-apache 

sudo apt install ddclient


sudo systemctl enable wg-quick@wg0.service
sudo systemctl daemon-reload
sudo systemctl start wg-quick@wg0
