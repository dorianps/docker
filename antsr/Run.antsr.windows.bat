@echo off
set /p MYPASSWORD="Select a session password: "

docker container run  -e PASSWORD=%MYPASSWORD% -p 8787:8787 -d --name myantsr --rm dorianps/antsr:latest
echo "Browser will open shortly. Enter username: rstudio pass: %MYPASSWORD%"
timeout 5
rundll32 url.dll,FileProtocolHandler http://localhost:8787
set /p dummy="Press enter to stop the antsr container..." \
docker stop myantsr
timeout 5