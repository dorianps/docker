# Docker containers for ANTsR / LINDA / LESYMAP
Tools to build and run docker containers with pre-installed ANTs, ANTsR, LINDA, or LESYMAP. R packages use RStudio accessed through the browser. The docker images reside in [DockerHub](https://hub.docker.com/u/dorianps) but scripts are provided so you can build fresh containers.
     
*Replace "antsr" with other package names below as needed.*

---

## Step 1: Install docker

##### Windows: install [Docker Desktop](https://www.docker.com/products/docker-desktop).
Docker Desktop works on Windows 10 Pro and Education, Windows Home users may need to install Docker in other ways. On some computers, you may need to enable Intel Virtualization Technology in BIOS, or allow the firewall for local connections on port 445 to share local folders with the container.
    
##### Linux: install `docker-ce`
Instructions for: [CentOS](https://docs.docker.com/install/linux/docker-ce/centos/), [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/), [Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/), [Debian](https://docs.docker.com/install/linux/docker-ce/debian/)    

---

## Step 2: Run the container
##### Windows: `Run.antsr.windows.bat` (double click)
##### Linux: `sh Run.antsr.linux.sh`
You will see a command line prompt asking a couple of questions, then the browser will open with the RStudio login page. When you are done, please press [enter] at the command line window to stop the ANTsR docker container. If you are running this command the first time, it will download the docker image from DockerHub [~800Mb]. The docker image with the tag `:latest` is the default image we use, it has the most recent ANTsR installation.

---

### Build your own container
*You can use the provided scripts to build the container yourself, if needed.*   
##### Windows: `Build.antsr.windows.bat` (double click)
##### Linux: `sh Build.antsr.linux.sh`
The script will build the ANTsR container on your machine using the latest ANTsR, ANTsRCore, ITKR from github. The built image will be tagged `dorianps/antsr:latest`. If you add the argument `--push` in linux it will push the image online at the DockerHub registry (you can change the DockerHub username in the script). Built time depends on the machine: ~1hr in Linux with Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz, or 1.7hr in Windows with Intel(R) Core(TM) i7-7660U CPU @ 2.50GHz.

---


# Q & A

#### How to start the container without a script?
```
docker container run -v /PATH/TO/LOCAL/FOLDER:/home/rstudio/mydata -e PASSWORD=[YOURPASSWORDHERE] -p 8787:8787 --rm dorianps/antsr:latest 
```

#### How do I check which ANTsR version is installed in the container?
The following command will print the semantic versions and git commits for all relevant packages:
```
docker run --rm dorianps/antsr:latest Rscript /home/rstudio/.Rprofile
```

#### Is the downloaded container updated automatically?
No, the local docker image you get the first time will not be updated automatically.

#### How do I update the local docker image?
To get the latest docker image from DockerHub (and overwrite your local one) run:
```
docker pull dorianps/antsr:latest
```
The command will download the container only if there is a newer version.
    
*Note: The container with the tag `:latest` available online may contain an ANTsR version different from what you have in your local `:latest` container. This means that the analyses may not produce the same results after you pull the latest update. To have reproducible results use a specific tag during a study conduct (i.e., `dorianps/antsr:20191104`) or avoid updating the `:latest` container.*

#### I installed other packages but can't find them after restarting the container!
The container you start with the above scripts will be stopped and deleted at the end of the session. A fresh container is started each time you run the script. If you want to keep your old container, remove the `--rm` flag in the call; you will need to stop and start the container manually after that (i.e., `docker container start myantsr`). However, the best practice is to create another docker image from the container you are using. This can be done easily with the `docker commit` command (google it). You can also save your docker image as a tar.gz file and load it later on another computer. This means you can have your study-specific docker image, install what you need on it, and keep the image file with your data to reproduce the study in the future.

#### Will I be able to easily retrieve the data saved in the container?
Not if you save the data in the container itself. Use the folder mounted from your host system to store files, you should see it in the container path:  `/home/rstudio/mydata`. Data saved there is actually saved on your computer and will not be deleted when the container is stopped.

#### Is ANTsR slower when running in a docker container compared to running on a real computer?
No, my own test showed  equivalent performance of docker and host system on a linux machine. See test [here](https://github.com/dorianps/docker/wiki/Linux:-Docker-vs.-Host-System-speed-test).

#### Is docker slower or faster than WSL when running ANTsR?
Docker is faster than the standard Windows Linux Subsystem available until 2020, but the new WSL2 is much improved and has comparable performance with Docker. See the [quick tests](https://github.com/dorianps/docker/wiki/Windows:-Docker-vs.-WSL-speed-test) I ran using LESYMAP.

#### How can I limit the amount of CPUs and memory used by the container?
By default, docker gives every container an unlimited amount of resources in linux. If your machine has 30 CPU cores, the container will see 30 CPU cores.     
In Windows, docker has more resource restrictions, you can set it to use all the available CPUs, but is not enabled by default. Also, you cannot assign to docker the entire memory in Windows. To change the Windows settings go to Docker > Settings > Advanced.    
Running a container with unlimited resources can sometimes be a problem. An `antsRegistration` call is capable of using all your CPU resources. To run a container with a limited number CPU cores, use the flag `--cpus`; e.g., `--cpus=2.0` will make the container see 2 CPU cores. Inside the containers built for ANTsR, we also set the variable `ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS` to the available number of CPUs [`$(nproc)`]. The available number of CPUs is displayed when RStudio starts.     
Memory flags and other resource restrictions can be set, too (see the [docker documentation](https://docs.docker.com/config/containers/resource_constraints/)).
