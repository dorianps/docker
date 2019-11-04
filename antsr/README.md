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
You will see a command line prompt asking a couple of questions, then the browser will open with the RStudio login page. When you are done, please press enter at the command line prompt to stop the ANTsR docker container. If you did not build the container yourself, it will be downloaded from DockerHub [~3Gb]. The container being started is the one with the tag `:latest`, which will contain always the most up to date ANTsR build.
  
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
You will see a command line prompt asking a couple of questions, then the browser will open with the RStudio login page. When you are done, please press enter at the command line prompt to stop the ANTsR docker container. If you did not build the container yourself, it will be download the `:latest` build from DockerHub [~3Gb]. The container being started is the one with the tag `:latest`, which will contain always the most up to date ANTsR build.



---

### How do I check which ANTsR version is installed in the container?
The following command will print the exact commit installed for ANTsR, ANTsRCore, ITKR:
```
docker run -u 0 --rm dorianps/antsr:latest Rscript /home/rstudio/.Rprofile
```

### How do I keep my local images up to date?
The docker image pulled from online will not be updated automatically. This means that DockerHub may have a more recent build. To get the most recent build type:
```
docker pull dorianps/antsr:latest
```
Note: unless you keep track of which build date the `:latest` tag refers to, you may see changes in software behavior if you update the local `:latest` tag. To have reproducible results, don't work with `:latest` tag but with another specific tag, i.e., `:20191104`.

### I installed some software but they are gone when I start the container again.
The container started with the above scripts is stopped and removed at the end of the session. You can keep the container in the system by removing the flag `--rm`, you can also start that container later by running `docker container run myantsr`. However, the best practice is to use the container you change to create another docker image. This can be done very easily with a `docker commit` command. You can also save the docker image you built as a tar.gz file and load it later on another computer. This means you can have your study-specific docker image that you use to install things, run analyses, and move between computers, while being sure that results will be fully reproducible 2 or 10 years from now.

### Will I be able to easily retrieve the data saved in the container?
Not if you save in any folder. Use the folder mounted from your host system to store files. You should see and save the data in `/home/rstudio/mydata`, and you can access them easily from your host computer also after the container is stopped and removed.
