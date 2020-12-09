#! /bin/sh

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
source ~/.bashrc
nvm install 8
nvm use 8
npm install npm@latest -g
