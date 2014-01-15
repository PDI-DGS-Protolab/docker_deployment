#!/bin/bash
expected_args=7	
CONFIG_FILE=autoDeployParams.conf
#reading the file
if [[ -f $CONFIG_FILE ]]; then
        . $CONFIG_FILE
fi
PARAMS=`wc -l < $CONFIG_FILE`
if [ $PARAMS -lt "$expected_args" ]; then
  	echo "Usage: autoDeploy.sh || configure parameters GITHUB_URL BRANCH CONTAINER_TAG LOCAL_PORT CONTAINER_PORT SSH_ADDRESS SSH_CREDENTIALS [ENVIRONMENT_VARS] in autoDeployParams.conf"
  	exit 1
else
	if [ $PARAMS -gt "$expected_args" ]; then 
		cat autoDeploy.sh | ssh $SSH_ADDR -i $SSH_CREDS "cat > /tmp/autoDeploy.sh ; 
		chmod 755 /tmp/autoDeploy.sh ; /tmp/autoDeploy.sh $GITHUB_URL $BRANCH $CONT_TAG $LOCAL_PORT $CONT_PORT $ENV_VARS"
	else 
		cat autoDeploy.sh | ssh $SSH_ADDR -i $SSH_CREDS "cat > /tmp/autoDeploy.sh ; 
		chmod 755 /tmp/autoDeploy.sh ; /tmp/autoDeploy.sh $GITHUB_URL $BRANCH $CONT_TAG $LOCAL_PORT $CONT_PORT"
	fi
	exit
fi
