#!/bin/bash

# a few linux commands to run the ANTsR docker container, open the browser, and wait for the user to stop the container

read -p "Select a session password for rstudio: " MYPASSWORD

# choosefolder
VOLUMEMOUNT=""
read -p "Do you want to mount a Windows folder in the container [y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
    read -p "Eneter a folder to mount in the container: " FOLDER
    VOLUMEMOUNT="-v $FOLDER:/home/rstudio/mydata"
fi

# runcontainer
docker container run $VOLUMEMOUNT -e PASSWORD=$MYPASSWORD -p 8787:8787 -d --name myantsr --rm dorianps/antsr:latest \
&& echo "Browser will open shortly. Enter username: 'rstudio' pass: '$MYPASSWORD'" \
&& sleep 5 \
&& xdg-open http://localhost:8787 \
&& read -p "Press enter to stop the container..." \
&& echo "Stopping container..." \
&& docker stop myantsr
