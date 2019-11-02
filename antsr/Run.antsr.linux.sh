#!/bin/bash

# a few linux commands to run the ANTsR docker container, open the browser, and wait for the user to stop the container
# This script can fully automatize opening rstudio with antsr in a single click of the bash file.
read -p "Select a session password: " MYPASSWORD \
&& docker container run  -e PASSWORD=$MYPASSWORD -p 8787:8787 -d --name myantsr --rm dorianps/antsr:latest \
&& echo "Browser will open shortly. Enter username: rstudio pass: $MYPASSWORD" \
&& sleep 5 \
&& xdg-open http://localhost:8787 \
&& read -p "Press enter to stop the antsr container..." \
&& docker stop myantsr