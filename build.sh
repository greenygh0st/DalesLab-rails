#!/bin/bash

#To use for CI
#crontab -e
#
# Run our job every minute
# * * * * * /repodironserver/build.sh

#Check to see if there have been any changes
git diff
if [ $? -eq 0 ]
then
  #If there are changes grab them
  git pull
  #Build the image
  docker build -t daleslab/site .
  #Stop the old container
  docker stop daleslab-livesite
  #Remove the old container
  docker rm daleslab-livesite
  #Start the new container
  docker run -d -p 8080:80 --name=daleslab-livesite -e DALESLAB_SECRET_KEY_BASE=$1 -e DALESLAB_SQLPASS=$2 -v /root/file-uploads/daleslab:/app/public/assets daleslab/site
fi
