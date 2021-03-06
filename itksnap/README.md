# Docker container with ITKsnap
ITKsnap is a graphic program to view and process imaging data (nifti, dicom, etc.). Homepage is at [itksnap.org](http://www.itksnap.org/). 

ITKsnap is a multiplatform program with builds for Windows, Linux, and Mac. So, normally you do not need a docker container to get the program. However, in some circumstances you may need to use Linux tools in Windows alongside ITKsnap. This is when the ITKsnap  container can be useful.

## Step 1: install docker
See instructions in [homepage](https://github.com/dorianps/docker)

----

## Step 2: Make sure you have an X-server installed
Linux and Mac should already have an X-server. On Windows, I reccommend [MobaXterm](https://mobaxterm.mobatek.net/) which is a nice suite with X-server inluded.

----

## Step 3: run the container
##### Windows: `Run.itksnap.windows.bat` (double click)
Make sure you open MobaXterm first or run the above script within MobaXterm after opening a command line shell. 
You will be asked if you want to mount a folder from your host system into the container. 
If you mount a folder, it will appear in `/home/itksnap/mydata`

### Build your own container
*You can use the provided scripts to build the container on your local machine.*   
##### Windows: `Build.ants.windows.bat` (double click)
##### Linux: `sh Build.ants.linux.sh`

---- 

# Q & A
   
#### How to start the container without a script?
```
docker run --rm -it -v /PATH/TO/LOCAL/FOLDER:/home/itksnap/mydata dorianps/itksnap:latest
```

#### How do I stop the container?
Just close the ITKsnap window; the container is removed when you exit because it is started with the `--rm` flag. 

#### Nothing appears when I load an image, and I see errors on the  terminal.
If ITKsnap opens but you don't see the data you loaded, and you see errors in the terminal like 
`QGLContext::makeCurrent(): Cannot make invalid context current`, 
there might be an OpenGL issue on your X-server. If you are using MobaXterm, 
try changing `Settings -> X11 -> OpenGL acceleration` to `Software`.

#### Can I install other software in the container?
Yes, the container is just a linux environment and you can install anything. But if you need administrative rights, you will need to start the container as root user (i.e., add `-u 0` to the run command). Note that the changes you make are not saved in the container image, and you may lose the changes at the end of the session. A workaround is to keep the container at the end of the session (remove the `--rm` flag) or create a new container image after your changes with the `docker commit` command.
