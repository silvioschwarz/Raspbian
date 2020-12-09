#! /bin/sh

echo "install Dependencies"
sudo apt update && sudo apt upgrade && sudo apt autoremove
sudo apt install gnupg2 build-essential zlib1g-dev

echo "fetch public keys and run installer"
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable

/bin/bash --logout
rvm requirements

#rvm install 2.1.2 # installing Ruby

echo "install ruby2.6"
rvm get stable --auto-dotfiles
rvm -v

echo "install github-pages builder jekyll gems"
gem install github-pages builder jekyll
