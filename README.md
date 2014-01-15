#Docker Auto Deployment
======

Script to auto deploy github projects in Docker


###How to
Give execution permissions to autoDeployIni.sh and execute the script. 

**Usage**: ./autoDeploy.sh


###Configuration Parameters
The file **autoDeployParams.conf** must follow the following syntax, all values are asigned **without ""**:
GITHUB_URL=*The URL to the GIT project*<br />
BRANCH=*The branch of the project to use*<br />
CONTAINER_TAG=*The tag that should be used to identify the image in Docker*<br />
LOCAL_PORT=*The port to which all request will be redirected from the container port*<br />
CONTAINER_PORT=*The port from the container that will be emitting*<br />
SSH_ADDRESS=*SSH address to the remote machine*<br />
SSH_CREDENTIALS=*SSH credentials to access said machine*<br />
ENVIRONMENT_VARS=**_optional_** *all environment vars that may be needed for the project*<br />