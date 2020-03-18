# a stupid simple RTMP Server in a Container/Docker 
<p align="center">
with ffmpeg
</p>

## Context:

*When testing RTMP connections with `ffmpeg` or `gstreamer` I mostly used the `nginx-rtmp-module` which is of course brilliant !!!*

---
## For commercial and Enterprise RTMP-LIVE-Streaming 
### please look at *BITMOVIN* !

https://bitmovin.com/encoding-service

and their RTMP-examples:

https://github.com/bitmovin/bitmovin-api-sdk-examples

<p align="center">
  <a href="https://www.bitmovin.com">
    <img width=60% alt="Bitmovin API SDK Examples Header" src="https://cdn.bitmovin.com/frontend/encoding/openapi-clients/readme-headers/Readme_OpenApi_Header.png" >
  </a>

  <h6 align="center">This repository provides examples demonstrating usage of the <br><a href="https://bitmovin.com/docs/encoding/sdks" target="_blank">Bitmovin API SDKs</a> in different programming languages.</h4>

  <p align="center">
    <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License"></img></a>
  </p>
</p>

---

<br>
But using this was sometimes a bit unhandy, so I wanted to just do it with a simple `ffmpeg`-cli command.

`ffmpeg` provides a listener mode for RTMP, so this was simple (after I found out that listening at `localhost` in my case did not work).

`ffmpeg -f flv -listen 1 -i rtmp://127.0.0.1:1935/live/ ...`

this worked like a charm for testing with OBS for example.

After I had a good script I wanted to port it to `docker` and wanted to amke it stable, means not abort after I diconnected with `OBS`. This is why I used `supervisord` in this container, as I never before used it but already stumbled upon it a couple of times.

This was a good opportunity to use it for the first time!

## How it works ?

1) install `ffmpeg` from the static `johnvansickle.com`-`ffmpeg-builds`
2) use a bash-script to create a `MPEG-DASH`-stream and create `thumbnails` with `ffmpeg`
3) look that it is always running by the use of `supervisord`

...

## build it 
`docker build -t riha/rtmp-server-ffmpeg .`

~~or ignore the cache~~

~~`docker build --no-cache -t riha/rtmp-server-ffmpeg .`~~

## run it

`docker run -it -p 1935:1935 -v $PWD/out:/output riha/rtmp-server-ffmpeg:latest`

_- make sure that the `out`-Folder on the host has a `dash`- & `thumbs`-subfolder !_

## *TODO:*

- configure ABR for DASH with a JSON-File -> https://starkandwayne.com/blog/bash-for-loop-over-json-array-using-jq/
- add config params for this server
    - RTMP-PORT
    - ABR-CONFIG-FILE
    - THUMBNAIL-FREQUENCY in seconds
    - OUPUT-FOLDER