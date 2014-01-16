#Docker Auto Deployment
======

Python script to auto deploy github projects in Docker


###How to
Give execution permissions to autoDeployIni.sh and execute the script. The param config_file is the file with the parameters to run the script.

**Usage**: ./autoDeployIni.sh config_file

###Configuration Parameters
The configuration file  must follow the following syntax, all values are asigned **without ""** and no punctuation marks between lines:

GITHUB_URL=*The URL to the GIT project*  
BRANCH=*The branch of the project to use*  
CONTAINER_TAG=*The tag that should be used to identify the image in Docker*  
LOCAL_PORT=*The port to which all request will be redirected from the container port*  
CONTAINER_PORT=*The port from the container that will be emitting*  
SSH_ADDR=*SSH address to the remote machine*
SSH_PORT=*SSH port to the remote machine*
SSH_USER=*SSH user to the remote machine*
SSH_PASS=*SSH user password to the remote machine*
SSH_CREDS=*SSH credentials to access said machine*  
ENV_VARS=*Not suported yet*
