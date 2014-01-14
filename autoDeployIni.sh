#!/bin/bash
expected_args=7	
GITHUB_URL="$1";BRANCH="$2";CONT_TAG="$3";LOCAL_PORT="$4";CONT_PORT="$5";SSH_ADDR="$6";SSH_CREDS="$7";ENV_VARS="$8";
if [ "$#" -lt "$expected_args" ]; then
  	echo "Usage: autoDeploy.sh GITHUB_URL BRANCH CONTAINER_TAG LOCAL_PORT CONTAINER_PORT SSH_ADDRESS SSH_CREDENTIALS [ENVIRONMENT_VARS]"
  	exit 1
else
	if [ "$#" -gt "$expected_args" ]; then 
		cat autoDeploy.sh | ssh $SSH_ADDR -i $SSH_CREDS "cat > /tmp/autoDeploy.sh ; 
		chmod 755 /tmp/autoDeploy.sh ; /tmp/autoDeploy.sh $GITHUB_URL $BRANCH $CONT_TAG $LOCAL_PORT $CONT_PORT $ENV_VARS"
	else 
		cat autoDeploy.sh | ssh $SSH_ADDR -i $SSH_CREDS "cat > /tmp/autoDeploy.sh ; 
		chmod 755 /tmp/autoDeploy.sh ; /tmp/autoDeploy.sh $GITHUB_URL $BRANCH $CONT_TAG $LOCAL_PORT $CONT_PORT"
	fi
	exit
fi
