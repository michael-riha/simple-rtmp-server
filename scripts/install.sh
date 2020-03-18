#!/bin/bash

#ffmpeg stuff
wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
mkdir ffmpeg-64bit-static-build
tar xf ffmpeg-release-amd64-static.tar.xz -C ffmpeg-64bit-static-build --strip-components 1
mv ffmpeg-64bit-static-build/ ffmpeg/
rm ffmpeg-release-amd64-static.tar.xz

#server stuff
mkdir /output
mkdir /output/dash
mkdir /output/thumbs
