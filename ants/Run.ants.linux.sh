#!/bin/bash

# a few linux commands to run the ANTsR docker container, open the browser, and wait for the user to stop the container
IMAGE=ants
USERNAME=dorianps

# choosefolder
VOLUMEMOUNT=""
read -p "Do you want to mount a folder in the container [y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
    read -p "Enter a folder to mount in the container: " FOLDER
    VOLUMEMOUNT="-v $FOLDER:/mydata"
fi

# runcontainer
docker container run $VOLUMEMOUNT --name my${IMAGE} --rm -it ${USERNAME}/${IMAGE}:latest
