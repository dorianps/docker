#!/bin/bash

# Script Script:  v1 (2019-11-02)
# Author   Dorian Pustina

# today's date in GMT timezone
IMAGE=linda
USERNAME=dorianps
TAGVERSION=$(date -u +'%Y%m%d') 
BUILDDATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
DOCKERFOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
PWDFOLDER=$(pwd)
cd $DOCKERFOLDER

# update local baseimage
BASEIMAGE=antsr
docker pull ${USERNAME}/${BASEIMAGE}:latest

# build the docker image, tag with today's date 
docker build --pull --label org.label-schema.version=${TAGVERSION} \
--label org.label-schema.build-date=${BUILDDATE} --rm -t ${USERNAME}/${IMAGE}:latest -f Dockerfile.${IMAGE} .
docker tag ${USERNAME}/${IMAGE}:latest ${USERNAME}/${IMAGE}:${TAGVERSION}


if [[ "$*" == "--push" ]]
then
  # push the images in DockerHub registry
  docker push ${USERNAME}/${IMAGE}:${TAGVERSION}
  docker push ${USERNAME}/${IMAGE}:latest
else
  echo "Skipping push to docker registry"
fi

# Windows users build like this: 
# docker build --rm -t dorianps/antsr:latest -f Dockerfile.antsr .


# Run example:
# docker container run -e PASSWORD=YOURPASSWORDHERE -v C:\PATH\TO\YOUR\DATA:/home/rstudio/mydata -p 8787:8787 --rm dorianps/antsr:latest
# then open a browser and go to http://localhost:8787. If you see the login page, put username: rstudio and password: YOUPASSWORDHERE.

cd $PWDFOLDER
