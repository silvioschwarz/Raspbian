#!/bin/sh
sudo apt install realvnc-vnc-server realvnc-vnc-viewer


sudo systemctl enable vncserver-virtuald.service
sudo systemctl enable vncserver-x11-serviced.service

sudo apt-get install -y mlocate build-essential git
sudo apt-get install -y libatlas-base-dev libssl-dev libffi-dev libxml2-dev libxslt-dev liblapack-dev libsuitesparse-dev libjpeg-dev zlib1g-dev libglib2.0-dev libgirepository1.0-dev libcairo2-dev libjpeg-dev libgif-dev libsdl1.2-dev libhdf5-dev

git config --global user.name "Silvio Schwarz"
git config --global user.email admin@silvioschwarz.xyz
