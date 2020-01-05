#!/bin/bash

# a few linux commands to run the ANTsR docker container, open the browser, and wait for the user to stop the container
IMAGE=linda
USERNAME=dorianps

read -p "Select a session password for rstudio: " MYPASSWORD
# check password is not empty
[[ -z $MYPASSWORD ]] && echo 'Empty password not allowed, existing...' && exit 1


# choosefolder
VOLUMEMOUNT=""
read -p "Do you want to mount a folder in the container [y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
    read -p "Enter a folder to mount in the container: " FOLDER
    VOLUMEMOUNT="-v $FOLDER:/home/rstudio/mydata"
fi

# browser open command for linux
OPENCMD='xdg-open'
# browser open command for Mac
[[ `uname` == "Darwin" ]] && OPENCMD='open'

# runcontainer
docker container run $VOLUMEMOUNT -e PASSWORD=$MYPASSWORD -p 8787:8787 -d --name my${IMAGE} --rm ${USERNAME}/${IMAGE}:latest \
&& echo "Browser will open shortly. Enter username: 'rstudio' pass: '$MYPASSWORD'" \
&& sleep 5 \
&& $OPENCMD http://localhost:8787 \
&& read -p "Press enter to stop the container..." \
&& echo "Stopping container..." \
&& docker stop my${IMAGE}
