#!/bin/sh

sudo apt-get update
sudo apt-get install uvcdynctrl

sudo apt-get install build-essential subversion libjpeg62-turbo-dev
sudo apt-get install imagemagick libv4l-0 libv4l-dev libjpeg-dev  libv4l-dev checkinstall 

svn co https://svn.code.sf.net/p/mjpg-streamer/code mjpg-streamer

cd mjpg-streamer/mjpg-streamer
#wget https://dl.dropboxusercontent.com/u/48891705/chip/input_uvc_patch
patch -p0 < input_uvc_patch

make USE_LIBV4L2=true clean all
sudo make install


sudo cp mjpg_streamer /usr/local/bin
sudo cp output_http.so input_file.so /usr/local/lib/