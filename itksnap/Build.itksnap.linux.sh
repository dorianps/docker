#!/bin/bash

# Script Script:  v1 (2020-01-05)
# Author   Dorian Pustina

# today's date in GMT timezone
IMAGE=itksnap
USERNAME=dorianps
TAGVERSION=$(date -u +'%Y%m%d') 
BUILDDATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
DOCKERFOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
PWDFOLDER=$(pwd)
cd $DOCKERFOLDER

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

cd $PWDFOLDER
