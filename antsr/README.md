# Docker builds for ANTsR
Contains the tools to promptly build and run a docker image with ANTsR including RStudio access through the browser.

## Linux
#### Build
Get all the files locally and run in command line:
```bash
sh Build.antsr.linux.sh
```
The script will run a fresh build of the ANTsR container with the latest ANTsR, ANTsRCore, ITKR packages. If you add the argument `--push` it will push the image online at the DockerHub registry (you can change your DockerHub username in the script). Estimated build time ~1hr on Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.

#### Run
```bash
sh Run.antsr.linux.sh
```
This script will ask you to set a session password, then start the ANTsR docker container and open the browser at the ANTsR container page. At the end you need to press enter to stop the ANTsR container. At the first run, the docker container will be donwloaded from DockerHub [~3Gb]  (if you did not build the container locally).


## Windows
#### Build
Double click the file:
```
Build.antsr.windows.bat
```
The script will run a fresh build of the ANTsR container with the latest ANTsR, ANTsRCore, ITKR packages. The container is named `dorianps/antsr:latest` in your local machine. Estimated build time ~1.7hrs on Intel(R) Core(TM) i7-7660U CPU @ 2.50GHz.

#### Run
Double click the file:
```
Run.antsr.windows.bat
```
You will see a command line prompt asking for a password, then the browser will open with the RStudio login page. When you are done, please press enter at the command line prompt to stop the ANTsR docker container. At the first run, the docker container will be donwloaded from DockerHub [~3Gb]  (if you did not build the container locally).

---

### How do I check which ANTsR version is installed in the container?
The following command will print the commits installed for ANTsR, ANTsRCore, ITKR:
```
docker run -u 0 --rm dorianps/antsr:latest Rscript /home/rstudio/.Rprofile
```


