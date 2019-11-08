# Docker images for ANTsR / LINDA / LESYMAP
This repository contains tools to build and run docker containers with pre-installed ANTsR, LINDA, or LESYMAP R packages. The RStudio GUI is accessed through the browser, and several other developer tools are integrated. The docker images are build locally on your computer and optionally pushed in [DockerHub](https://hub.docker.com/u/dorianps).
     
*The instructions below are valid for every package in the subfolders; just replace [antsr] with another package name.*

---

## Requirement
You must have Docker installed to build and run docker images.

##### Windows: install [Docker Desktop](https://www.docker.com/products/docker-desktop).
Docker Desktop works on Windows 10 Pro and Education, Windows Home users may need to install Docker in other ways. On some computers, you may need to enable Intel Virtualization Technology in BIOS, or allow the firewall for local connections on port 445 to share local folders with the container.
    
##### Linux: install `docker-ce`

---

## Run
##### Windows: `Run.antsr.windows.bat` (double click)
##### Linux: `sh Run.antsr.linux.sh`
You will see a command line prompt asking a couple of questions, then the browser will open with the RStudio login page. When you are done, please press [enter] at the command line window to stop the ANTsR docker container. If you are running this command the first time, it will download the docker image from DockerHub [~800Mb]. The docker image with the tag `:latest` is the default image we use, it contains the most up to date ANTsR build if you just downloaded it.

---

## Build
*You can use these scripts to build the container yourself if the online version is too old.*   
##### Windows: `Build.antsr.windows.bat` (double click)
##### Linux: `sh Build.antsr.linux.sh`
The script will build the ANTsR container on your machine using the latest ANTsR, ANTsRCore, ITKR from github. The built image will be tagged `dorianps/antsr:latest`. If you add the argument `--push` in linux it will push the image online at the DockerHub registry (you can change the DockerHub username in the script). Built time depends on the machine: ~1hr in Linux with Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz, or 1.7hr in Windows with Intel(R) Core(TM) i7-7660U CPU @ 2.50GHz.

---


# Q & A

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
The container you start with the above scripts will be stopped and deleted at the end of the session. A fresh container is started each time you run the script. If you want to keep your old container, remove the `--rm` flag in the call; you will need to stop and start the container manually after that (i.e., `docker container start myantsr`). However, the best practice is to create another docker image from the container you are using. This can be done easily with the `docker commit` command (google it). You can also save your docker image as a tar.gz file and load it later on another computer. This means you can have your study-specific docker image, install what you need on it, and keep the image file with your data to reproduce the study in the future.

### Will I be able to easily retrieve the data saved in the container?
Not if you save the data in the container itself. Use the folder mounted from your host system to store files, you should see it in the container path:  `/home/rstudio/mydata`. Data saved there is actually saved on your computer and will not be deleted when the container is stopped.

### Is ANTsR slower when running in a docker container compared to running on a real computer?
I have not tested ANTsR yet, but I have seen convincing evidence that processes running in containers are almost as fast as in the host system. This is different from virtual machines which run processes slower than the host system. This is also one of the reasons why containers have become popular: they are quick to start, they provide an isolated reproducible environment, and they run processes as fast as the host machine.

### How can I limit the amount of CPUs and memory used by the container?
By default, docker gives every container an unlimited amount of resources in linux. If your machine has 30 CPU cores, the container will see 30 CPU cores.     
In Windows, docker has more resource restrictions, you can set it to use all the available CPUs, but is not enabled by default. Also, you cannot assign to docker the entire memory in Windows. To change the Windows settings go to Docker > Settings > Advanced.    
Running a container with unlimited resources can sometimes be a problem. An `antsRegistration` call is capable of using all your CPU resources. To run a container with a limited number CPU cores, use the flag `--cpus`; e.g., `--cpus=2.0` will make the container see 2 CPU cores. Inside the containers built for ANTsR, we also set the variable `ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS` to the available number of CPUs [`$(nproc)`]. The available number of CPUs is displayed when RStudio starts.     
Memory flags and other resource restrictions can be set, too (see the [docker documentation](https://docs.docker.com/config/containers/resource_constraints/)).
