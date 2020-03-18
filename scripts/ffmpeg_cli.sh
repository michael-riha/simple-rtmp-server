#!/bin/bash

# Encoding settings for x264 (CPU based encoder)
x264enc='libx264 -tune zerolatency -profile:v high -preset veryfast -bf 0 -refs 3 -sc_threshold 0'

/ffmpeg/ffmpeg \
    -hide_banner \
    -re \
    -f flv -listen 1 \
    -i rtmp://0.0.0.0:1935/live/app \
    -pix_fmt yuv420p \
    -map 0:v \
    -c:v ${x264enc} \
    -g 150 \
    -keyint_min 150 \
    -b:v 1500k \
    -seg_duration 4 \
    -streaming 1 \
    -utc_timing_url "https://time.akamai.com/?iso" \
    -index_correction 1 \
    -use_timeline 0 \
    -media_seg_name 'chunk-stream-$RepresentationID$-$Number%05d$.m4s' \
    -init_seg_name 'init-stream1-$RepresentationID$.m4s' \
    -window_size 5  \
    -extra_window_size 10 \
    -remove_at_exit 1 \
    -adaptation_sets "id=0,streams=v" \
    -f dash \
    /output/dash/manifest.mpd \
    -vf fps=1/15 \
    -vcodec png -an -f image2 -y /output/thumbs/stream_%06d.png

# clean up the thumbs folder -> https://askubuntu.com/questions/72446/how-to-remove-all-files-and-subdirectories-in-a-directory-without-deleting-the-d
rm -rfv /output/thumbs/*