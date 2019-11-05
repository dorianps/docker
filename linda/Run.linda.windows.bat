@echo off
REM Script:  v1 (2019-11-02)
REM Author   Dorian Pustina
setlocal

set IMAGE=linda
set USERNAME=dorianps

set /p MYPASSWORD="Select a session password for rstudio: "

set VOLUMEMOUNT=

set /P askmountfolder=Do you want to mount a Windows folder in the container[Y/[N]]?  
if /I "%askmountfolder%"=="Y" goto :choosefolder

:runcontainer
docker container run %VOLUMEMOUNT% -e PASSWORD=%MYPASSWORD% -p 8787:8787 -d --name my%IMAGE% --rm %USERNAME%/%IMAGE%:latest
echo Browser will open shortly. Enter username: "rstudio" pass: "%MYPASSWORD%"
timeout 5
rundll32 url.dll,FileProtocolHandler http://localhost:8787
set /p dummy="Press enter to stop the container..."
echo Stopping container...
docker stop my%IMAGE%
timeout 5
exit /B

:choosefolder
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Choose a folder to mount in the container...',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"
set VOLUMEMOUNT=-v "%folder%":/home/rstudio/mydata
echo Your folder '%folder%' will appear in '/home/rstudio/mydata'
goto :runcontainer


endlocal
