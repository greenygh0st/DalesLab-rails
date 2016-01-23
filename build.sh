#!/bin/bash

#
#
docker build -t daleslab/site .
docker stop daleslab/livesite
docker rm daleslab/livesite
docker run -d -p 8080:80 --name=daleslab-livesite -e DALESLAB_SECRET_KEY_BASE=secretkey -v /root/file-uploads/daleslab:/app/public/assets daleslab/site
