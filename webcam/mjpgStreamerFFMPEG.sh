# [Varables]
source_stream="http://localhost:8080/?action=stream"
destination_directory="/home/pi/Videos"
destination_file="cncjs-recording_$(date +'%Y%m%d_%H%M%S').mpeg"

# Recored Stream w/ ffmpeg
ffmpeg -f mjpeg -re -i "${source_stream}" -q:v 10 "${destination_directory}/${destination_file}"
