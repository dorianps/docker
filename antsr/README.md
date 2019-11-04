# Docker images for ANTsR
Contains tools to build or run docker containers with ANTsR installed. The RStudio GUI is accessed through the browser, and several developer tools are available so that other packages can be installed easily. The docker images themselves are available in [DockerHub](https://hub.docker.com/u/dorianps) and are downloaded automatically for new users.


## Windows
#### Build
Double click the file:
```
Build.antsr.windows.bat
```
The script will build the ANTsR container on your machine using the latest ANTsR, ANTsRCore, ITKR from github. The container is named `dorianps/antsr:latest` in your local machine. Estimated build time ~1.7hrs on Intel(R) Core(TM) i7-7660U CPU @ 2.50GHz. Note, you don't need to build the container yourself, you can pull the container directly from DockerHub using the run script below.

#### Run
Double click the file:
```
Run.antsr.windows.bat
```
You will see a command line prompt asking a couple of questions, then the browser will open with the RStudio login page. When you are done, please press enter at the command line prompt to stop the ANTsR docker container. If you did not build the container yourself, it will be downloaded from DockerHub [~3Gb]. The container being started is the one with the tag `:latest`, which will contain always the most up to date ANTsR container.
  
## Linux
#### Build
Get all the files locally and run in command line:
```bash
sh Build.antsr.linux.sh
```
The script will build the ANTsR container on your machine using the latest ANTsR, ANTsRCore, ITKR from github. If you add the argument `--push` it will push the image online at the DockerHub registry (you can change your DockerHub username in the script). Estimated build time ~1hr on Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz. Note, you don't need to build the container yourself, you can pull the container directly from DockerHub using the run script below.

#### Run
```bash
sh Run.antsr.linux.sh
```
You will see a command line prompt asking a couple of questions, then the browser will open with the RStudio login page. When you are done, please press enter at the command line prompt to stop the ANTsR docker container. If you did not build the container yourself, it will be download the `:latest` build from DockerHub [~3Gb]. The container being started is the one with the tag `:latest`, which will contain always the most up to date ANTsR container.



---

### How do I check which ANTsR version is installed in the container?
The following command will print the exact commit installed for ANTsR, ANTsRCore, ITKR:
```
docker run -u 0 --rm dorianps/antsr:latest Rscript /home/rstudio/.Rprofile
```


