@echo off

echo This script will start the antsr docker build

timeout 15

REM setup variables used later
SET USERNAME=dorianps
SET IMAGE=antsr
SET TAGVERSION=%date:~10,4%%date:~4,2%%date:~7,2%
SET BUILDDATE=%date%
SET DOCKERFOLDER=%~dp0
SET PWDFOLDER=%cd%
cd /d %DOCKERFOLDER%

REM build the docker image, tag with today's date 
docker build --pull --label org.label-schema.version="%TAGVERSION%" --label org.label-schema.build-date="%BUILDDATE%" --rm -t %USERNAME%/%IMAGE%:latest -f Dockerfile.%IMAGE% .
docker tag %USERNAME%/%IMAGE%:latest %USERNAME%/%IMAGE%:%TAGVERSION%

echo "Docker built commands ended, exiting shortly."

timeout 15


cd /d %PWDFOLDER%
