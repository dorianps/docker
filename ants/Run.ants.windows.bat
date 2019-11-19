@echo off
REM Script:  v1
REM Author   Dorian Pustina
setlocal

set IMAGE=ants
set USERNAME=dorianps


set VOLUMEMOUNT=

set /P askmountfolder=Do you want to mount a Windows folder in the container[Y/[N]]?  
if /I "%askmountfolder%"=="Y" goto :choosefolder

:runcontainer
echo docker container run %VOLUMEMOUNT% --name my%IMAGE% --rm -it %USERNAME%/%IMAGE%:latest
docker container run %VOLUMEMOUNT% --name my%IMAGE% --rm -it %USERNAME%/%IMAGE%:latest

echo End of session!
timeout 10
exit /B

:choosefolder
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Choose a folder to mount in the container...',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"
set VOLUMEMOUNT=-v "%folder%":/mydata
echo Your folder '%folder%' will appear in '/mydata'
goto :runcontainer


endlocal
