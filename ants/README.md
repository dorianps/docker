# Docker container with ANTs
ANTs is a comprehensive suite for processing (neuro)imaging data (homepage [here](https://github.com/ANTsX/ANTs)).   
Quick guide how to run the docker container.

## Step 1: install docker
See instructions in [homepage](https://github.com/dorianps/docker)

----

## Step 2: run the container
##### Windows: `Run.ants.windows.bat` (double click)
##### Linux: `sh Run.ants.linux.sh`
You will be asked about some settings and then you will see the prompt inside the container itself. The information on ANTs version will show as below:
```
----------------- ANTs environment ---------------
ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS:   2
ANTs git commit:        0889581eceb73debcd38fd749bef8e733b1bc358
ANTs build date:        Tue Nov 19 02:36:08 UTC 2019
ANTSPATH:               /opt/ANTs/bin/
```

----

### Build your own container
*You can use the provided scripts to build the container on your local machine.*   
##### Windows: `Build.ants.windows.bat` (double click)
##### Linux: `sh Build.ants.linux.sh`

Yes, you can build ANTs directly in Windows and use it there, through docker.

---- 

# Q & A
   
#### How to start the container without a script?
```
docker run --rm -it -v /PATH/TO/LOCAL/FOLDER:/mydata dorianps/ants:latest
```

#### How do I stop the container?
Simply type "exit"; the container is removed when you exit because it is started with the `--rm` flag 

#### Where is my folder data in the container?
If you use the scripts, your local folder is mounted at `/mydata`.
