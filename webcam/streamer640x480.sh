#!/bin/sh

/usr/local/bin/mjpg_streamer -i "/usr/local/lib/input_uvc.so -y -n -f 10 -r 640x480" \
-o "/usr/local/lib/output_http.so -p 80 -w /usr/local/www" &
