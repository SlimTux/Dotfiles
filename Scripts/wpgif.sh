#!/bin/sh

name=$(uuidgen | cut -d'-' -f1)

echo "Downloading video section..."
ffmpeg -i $(yt-dlp -f bestvideo --get-url $1) -ss $2  -to $3 -f mp4 /tmp/gm-1.mp4

echo "Making video slow..."
ffmpeg -i /tmp/gm-1.mp4 -vf 'setpts=2.0*PTS' -f mp4 /tmp/gm-2.mp4

echo "Adding effect and converting into gif..."
ffmpeg -i /tmp/gm-2.mp4 -vf 'eq=brightness=0.06:saturation=2' -f gif ~/pix/wall/gif/$name.gif

echo "Applying wallpaper!"
xgifwallpaper img ~/pix/wall/gif/$name.gif
