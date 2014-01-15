#Docker Auto Deployment
=======================

Script to auto deploy github projects in Docker

######How to:
- give execution permissions to autoDeployIni.sh and execute the script. 

**Usage**: ./autoDeploy.sh

######Configuration Parameters
The file **autoDeployParams.conf** must follow the following syntax, all values are asigned **without ""**:
GITHUB_URL=The URL to the GIT project <br />
BRANCH=The branch of the project to use
CONTAINER_TAG=The tag that should be used to identify the image in Docker
LOCAL_PORT=The port to which all request will be redirected from the container port
CONTAINER_PORT=The port from the container that will be emitting
SSH_ADDRESS=SSH address to the remote machine
SSH_CREDENTIALS=SSH credentials to access said machine
ENVIRONMENT_VARS=**optional** all environment vars that may be needed for the project
