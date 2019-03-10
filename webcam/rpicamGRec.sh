#! /bin/sh

gst-launch-0.10 -v tcpclientsrc host=192.168.1.104 port=5000 ! gdpdepay ! rtph264depay ! ffdec_h264 ! ffmpegcolorspace ! autovideosink sync=false

