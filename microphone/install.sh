#!/bin/sh

sudo apt-get install gstreamer0.10-pulseaudio libao4 libasound2-plugins libgconfmm-2.6-1c2 libglademm-2.4-1c2a libpulse-dev libpulse-mainloop-glib0 libpulse-mainloop-glib0-dbg libpulse0 libpulse0-dbg libsox-fmt-pulse paman paprefs pavucontrol pavumeter pulseaudio pulseaudio-dbg pulseaudio-esound-compat pulseaudio-esound-compat-dbg pulseaudio-module-bluetooth pulseaudio-module-gconf pulseaudio-module-jack pulseaudio-module-lirc pulseaudio-module-lirc-dbg pulseaudio-module-x11 pulseaudio-module-zeroconf pulseaudio-module-zeroconf-dbg pulseaudio-utils oss-compat -y

sudo \cp -pf /etc/asound.conf /etc/asound.conf.ORIG 
sudo echo 'pcm.pulse {
    type pulse
}

ctl.pulse {
    type pulse
}

pcm.!default {
    type pulse
}

ctl.!default {
    type pulse
}' > /etc/asound.conf


_DEVICE_LOAD_ON_START=$(grep "snd.bcm2835" /etc/modules | wc -l)
if [[ "${_DEVICE_LOAD_ON_START}" = "0" ]]; then

  sudo \cp -pf /etc/modules /etc/modules.ORIG
  sudo echo "snd-bcm2835" >> /etc/modules

fi

# Disallow module loading after startup. This is a security feature since it disallows additional module loading during runtime and on user request.
_DISALLOW_MODULE_LOADING=$(grep "DISALLOW_MODULE_LOADING=1" /etc/default/pulseaudio | wc -l)
if [[ "${_DISALLOW_MODULE_LOADING}" = "0" ]]; then

  sudo \cp -pf /etc/default/pulseaudio /etc/default/pulseaudio.ORIG
  sudo sed -i "s,DISALLOW_MODULE_LOADING=1,DISALLOW_MODULE_LOADING=0,g" /etc/default/pulseaudio

fi

# allow other clients on the network to connect to pulseaudio daemon ( only add auth-anonymous=1 if you know EVERY machine on your LAN ... this could be a security risk otherwise )
sudo \cp -fvp /etc/pulse/system.pa /etc/pulse/system.pa.ORIG
sudo echo "
# ScarlettPi ADDED THIS
load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;192.168.0.0/24 auth-anonymous=1
load-module module-zeroconf-publish" >> /etc/pulse/system.pa

sudo echo "
# ScarlettPi added this
#load-module module-native-protocol-tcp
#load-module module-zeroconf-publish
load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;192.168.0.0/24 auth-anonymous=1
load-module module-zeroconf-publish" >> /etc/pulse/default.pa

# check to make sure it looks okay
cat /etc/pulse/default.pa

sudo \cp -fvp /etc/libao.conf /etc/libao.conf.ORIG
sudo sed -i "s,default_driver=alsa,default_driver=pulse,g" /etc/libao.conf 

# daemon settings according to Pi-Musicbox ( https://github.com/woutervanwijk/Pi-MusicBox )
sudo \cp -fvp /etc/pulse/daemon.conf /etc/pulse/daemon.conf.ORIG

sudo echo "
# ScarlettPi added this
high-priority = yes
nice-level = 5
exit-idle-time = -1
resample-method = src-sinc-medium-quality
default-sample-format = s16le
default-sample-rate = 48000
default-sample-channels = 2" >> /etc/pulse/daemon.conf.ORIG

sudo adduser pi pulse-access

# shut down the machine to make sure all the settings we just made are loaded correctly
sudo shutdown -r now


export LD_LIBRARY_PATH=/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# also add these to your .bashrc so they get set once you login 
echo "
# scarlettPi added this
export LD_LIBRARY_PATH=/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig" >> ~/.bashrc


# install python dev packages
sudo apt-get install python2.7-dev -y

# sphinxbase install ( required to install pocketsphinx )
sudo apt-get install bison -y
cd ~pi/
wget  http://downloads.sourceforge.net/project/cmusphinx/sphinxbase/0.8/sphinxbase-0.8.tar.gz
tar -xvf sphinxbase-0.8.tar.gz
cd sphinxbase-0.8
./configure
make
sudo make install
cd -

# pocketsphinx install
# set this: LD_LIBRARY_PATH=/path/to/pocketsphinxlibs /usr/local/bin/pocketsphinx_continuous
# http://www.voxforge.org/home/forums/message-boards/speech-recognition-engines/howto-use-pocketsphinx
wget http://sourceforge.net/projects/cmusphinx/files/pocketsphinx/0.8/pocketsphinx-0.8.tar.gz
tar -xvf pocketsphinx-0.8.tar.gz
cd pocketsphinx-0.8
./configure
make
sudo make install
cd -

# install sphinxtrain
wget http://sourceforge.net/projects/cmusphinx/files/sphinxtrain/1.0.8/sphinxtrain-1.0.8.tar.gz
tar -xvf sphinxtrain-1.0.8
cd sphinxtrain-1.0.8
./configure
make
sudo make install
cd -

ps aux | grep pulse

# If it isn't, start it up yourself ( need to figure out the best way to make this run on boot...init.d script maybe? )
/usr/bin/pulseaudio --start --log-target=syslog --system=false
