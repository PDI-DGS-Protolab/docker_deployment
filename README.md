#Docker Auto Deployment in Python
======

Python program to auto deploy github projects in Docker


###How to
Give execution permissions to autoDeployIni.py and execute the file. If the _-o_ option is set then the program will kill any processes running in Docker that are using the LOCAL_PORT stated in the configuration file.

**Usage**: ./autoDeployIni.sh [-o] _configurationFile_


###Configuration Parameters
The file _configurationFile_ must follow the following syntax, all values are asigned **without "" or ''**, no punctuation marks between lines and no spaces between = and values:

GITHUB_URL=*The URL to the GIT project, without .git extension*  
BRANCH=*The branch of the project to use*  
CONTAINER_TAG=*The tag that should be used to identify the image in Docker*  
LOCAL_PORT=*The port to which all request will be redirected from the container port*  
CONTAINER_PORT=*The port from the container that will be emitting*  
SSH_ADDRESS=*SSH ip address to the remote machine* 
SSH_USER=*SSH username to the remote machine* 
SSH_CREDENTIALS=*SSH key file to access said machine*  
ENVIRONMENT_VARS=All environment vars that may be needed for the project*