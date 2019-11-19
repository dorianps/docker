## Step 1: install docker
See instructions in [homepage](https://github.com/dorianps/docker)

----

## Step 2: run the container
##### Windows: `Run.ants.windows.bat` (double click)
##### Linux: `sh Run.ants.linux.sh`
You will see a command line prompt asking a couple of questions, and will see the prompt of the container. Some info on the ANTs version installed will appear.
```
----------------- ANTs environment ---------------
ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS:   2
ANTs git commit:        0889581eceb73debcd38fd749bef8e733b1bc358
ANTs build date:        Tue Nov 19 02:36:08 UTC 2019
ANTSPATH:               /opt/ANTs/bin/
```

----

#### How to start the container without a script?
```
docker run --rm -it -v /PATH/TO/LOCAL/FOLDER:/mydata dorianps/ants:latest
```

#### How do I stop the container?
Simply type "exit"; the container is removed when you exit because is started with the `--rm` flag 

#### Where is my folder data in the container?
If you use the scripts, your local folder is mounter in `/mydata`.
