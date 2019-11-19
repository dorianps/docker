## Step 1: install docker
See instructions in [homepage](../Readme.md)

----

## Step 2: run the container
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
