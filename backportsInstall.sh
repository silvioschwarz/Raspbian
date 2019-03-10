#! /bin/sh

sudo apt install dirmngr
gpg --keyserver pgpkeys.mit.edu --recv-key  8B48AD6246925553
gpg -a --export 8B48AD6246925553 | sudo apt-key add -
gpg --keyserver pgpkeys.mit.edu --recv-key  7638D0442B90D010
gpg -a --export 7638D0442B90D010 | sudo apt-key add -
