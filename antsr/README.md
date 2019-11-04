# Docker images for ANTsR / LINDA/ LESYMAP
Contains tools to build or run docker containers with ANTsR, LINDA, or LESYMAP installed. The RStudio GUI is accessed through the browser, and several developer tools are available so that other packages can be installed easily. The docker images themselves are available in [DockerHub](https://hub.docker.com/u/dorianps) and are downloaded automatically for new users.
   
*All the instructions below are valid if you go in the respective folder and substitute [antsr] with the other package name.*

## Run
##### Windows: double click `Run.antsr.windows.bat`
##### Linux: `sh Run.antsr.linux.sh`
You will see a command line prompt asking a couple of questions, then the browser will open with the RStudio login page. When you are done, please press [enter] at the command line prompt to stop the ANTsR docker container. If you did not build the container yourself, it will be downloaded from DockerHub [~3Gb]. The container being started is the one with the tag `:latest`, which will contain the most up to date ANTsR build if you just downloaded it.

## Build
Windows: double click **`Build.antsr.windows.bat`**
Linux: **`sh Build.antsr.linux.sh`**
The script will build the ANTsR container on your machine using the latest ANTsR, ANTsRCore, ITKR from github. If you add the argument `--push` in linux it will push the image online at the DockerHub registry (you can change your DockerHub username in the script). Estimated build time varies between ~1hr (Linux with Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz) and 1.7hr (Windows with Intel(R) Core(TM) i7-7660U CPU @ 2.50GHz).
*Note: this build step is not required to run the container, you can use the prepared container available in DockerHub.*

---
---
---
## Q & A

### How do I check which ANTsR version is installed in the container?
The following command will print the installed versions and git commits for ANTsR, ANTsRCore, ITKR:
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
    
Note: The container with the tag `:latest` available online may contain an ANTsR version more recent and different from what you had on your computer. This means that the analyses may not produce the same results after you pull the latest update. To have reproducible results use a specific tag (i.e., `dorianps/antsr:20191104`) or avoid updating the `:latest` container. The date and version of the R packages installed are shown when you start RStudio, or with the command:
```
docker run -u 0 --rm dorianps/antsr:latest Rscript /home/rstudio/.Rprofile
```

### I can't find the packages I installed after restarting the container.
The container you start with the above scripts will be stopped and deleted at the end of the session. A fresh container is started each time you run the script. If you want to keep your old container, remove the `--rm` flag in the call; you will need to stop and start the container manually after that (i.e., `docker container start myantsr`). However, the best practice - if you want to keep the container you worked on - is to create another docker image from the container you are using. This can be done easily with the `docker commit` command (google it). You can also save your docker image as a tar.gz file and load it later on another computer. This means you can have your study-specific docker image and keep that image with your data to run a fully reproducible analysis in the future.

### Will I be able to easily retrieve the data saved in the container?
Not if you save the data in the container itself. Use the folder mounted from your host system to store files, you should see it in the container path:  `/home/rstudio/mydata`. Data saved there is actually saved on your computer and will not be deleted when the container is stopped.
