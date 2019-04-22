#! /bin/sh

echo "install Dependencies"
sudo apt update && sudo apt upgrade && sudo apt autoremove
sudo apt install gnupg2 build-essential zlib1g-dev

echo "fetch public keys and run installer"
sudo gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | sudo bash -s stable

echo "set permissions"
sudo usermod -a -G rvm pi
if sudo grep -q secure_path /etc/sudoers; then sudo sh -c "echo export rvmsudo_secure_path=1 >> /etc/profile.d/rvm_secure_path.sh" && echo Environment variable installed; fi

echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo "install ruby2.6"
rvm get stable --auto-dotfiles
rvm -v

echo "install github-pages builder jekyll gems"
gem install github-pages builder jekyll
