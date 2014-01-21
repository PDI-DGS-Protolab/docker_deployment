#Docker Auto Deployment
======

Script to auto deploy github projects in Docker


###How to
Give execution permissions to autoDeployIni.sh and execute the script. If the _-o_ option is set then the script will kill any processes running in Docker that are using the LOCAL_PORT stated in the configuration file, and also will remove any previous image created with name _CONTAINER___TAG_, and so start all over creating a new image, without using the cache, downloading any changes that may have been done in the code.   
Option _-o_ will not work if there's another container, in another LOCAL_PORT using the same image.

**Usage**: ./autoDeployIni.sh _-o_ 


###Configuration Parameters
The file **autoDeployParams.conf** must follow the following syntax, all values are asigned **without ""** and no punctuation marks between lines:

GITHUB_URL=*The URL to the GIT project*  
BRANCH=*The branch of the project to use*  
CONTAINER_TAG=*The tag that should be used to identify the image in Docker*  
LOCAL_PORT=*The port to which all request will be redirected from the container port*  
CONTAINER_PORT=*The port from the container that will be emitting*  
SSH_ADDRESS=*SSH address to the remote machine*  
SSH_CREDENTIALS=*SSH credentials to access said machine*  
ENVIRONMENT_VARS=**_optional_** *all environment vars that may be needed for the project*  