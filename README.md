# Docker images for ANTsR / LINDA / LESYMAP
Contains tools to build or run docker containers with pre-installed ANTsR, LINDA, or LESYMAP. The RStudio GUI is accessed through the browser, and several developer tools are available so that other packages can be installed easily. The docker images themselves are available in [DockerHub](https://hub.docker.com/u/dorianps) and are downloaded automatically for new users.
   
*The instructions below are valid for every package in the subfolders; just replace [antsr] with another package name.*

---

## Prepare
You must have Docker installed to build and run docker images. In linux you can get docker-ce, in Windows you can get [Docker Desktop](https://www.docker.com/products/docker-desktop).
After that, download the files from this repository on your computer.

---

## Run
##### Windows: `Run.antsr.windows.bat` (double click)
##### Linux: `sh Run.antsr.linux.sh`
You will see a command line prompt asking a couple of questions, then the browser will open with the RStudio login page. When you are done, please press [enter] at the command line window to stop the ANTsR docker container. If you are running this command the first time, it will be download the necessary docker image from DockerHub [~3Gb]. The docker image that will be used is the one with the tag `:latest`, which will contain the most up to date ANTsR build if you just downloaded it.

---

## Build
*You can use these scripts to build the container yourself if the online version is too old.*   
##### Windows: `Build.antsr.windows.bat` (double click)
##### Linux: `sh Build.antsr.linux.sh`
The script will build the ANTsR container on your machine using the latest ANTsR, ANTsRCore, ITKR from github. If you add the argument `--push` in linux it will push the image online at the DockerHub registry (you can change your DockerHub username in the script). Estimated build time varies between ~1hr (Linux with Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz) and 1.7hr (Windows with Intel(R) Core(TM) i7-7660U CPU @ 2.50GHz).

---


## Q & A

### How do I check which ANTsR version is installed in the container?
The following command will print the semantic versions and git commits for all relevant packages:
```
docker run -u 0 --rm dorianps/antsr:latest Rscript /home/rstudio/.Rprofile
```

### Is the downloaded container updated automatically?
No, the local docker image you get the first time will not be updated automatically.

### How do I update the local docker image?
To get the latest docker image from DockerHub (and overwrite your local one) run:
```
docker pull dorianps/antsr:latest
```
The command will download the container only if there is a newer version.
    
*Note: The container with the tag `:latest` available online may contain an ANTsR version different from what you have in your local `:latest` container. This means that the analyses may not produce the same results after you pull the latest update. To have reproducible results use a specific tag during a study conduct (i.e., `dorianps/antsr:20191104`) or avoid updating the `:latest` container.*

### I installed other packages but can't find them after restarting the container!
The container you start with the above scripts will be stopped and deleted at the end of the session. A fresh container is started each time you run the script. If you want to keep your old container, remove the `--rm` flag in the call; you will need to stop and start the container manually after that (i.e., `docker container start myantsr`). However, the best practice - if you want to keep the container you worked on - is to create another docker image from the container you are using. This can be done easily with the `docker commit` command (google it). You can also save your docker image as a tar.gz file and load it later on another computer. This means you can have your study-specific docker image and keep that image with your data to run a fully reproducible analysis in the future.

### Will I be able to easily retrieve the data saved in the container?
Not if you save the data in the container itself. Use the folder mounted from your host system to store files, you should see it in the container path:  `/home/rstudio/mydata`. Data saved there is actually saved on your computer and will not be deleted when the container is stopped.

### Is ANTsR used from docker containers slower then ANTsR installed in the host system?
I have not tested ANTsR yet, but there is plenty of evidence showing that the speed of processing of containers is similar to the host system itself. This is different from virtual machines which are substantially slower than containers or the host system. This is also one of the reasons containers are being used everywhere: they are quick to start, they create an isolated reproducible environment, and they perform as fast as the host machine.

### How can I limit the amount of CPUs and memory used by the container?
By default, docker gives every container an unlimited amount of resrouces in linux. If your machine has 30 CPU cores, the container will see 30 CPU cores. In Windows, docker has more resource restrictions, you can set it to use all the available CPUs, but is not enabled by default. Also, you cannot use assign to docker the entire memory in Windows. To change the Windows settings got to Docker Settings > Advanced.    
To run a container with a specific number of CPU cores, use the flag `--cpus`; e.g., `--cpus=2.0` will make the container see 2 CPU cores. Inside the containers built for ANTsR, we set the variable `ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS` to the available number of CPUs (`$(nproc)`).  To change memory limits and other resources, see the [docker documentation](https://docs.docker.com/config/containers/resource_constraints/).
