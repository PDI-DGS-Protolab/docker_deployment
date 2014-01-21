#!/bin/bash
OVERRIDE="$1"
expected_args=7	
CONFIG_FILE=autoDeployParams.conf
#reading the file
if [[ -f $CONFIG_FILE ]]; then
        . $CONFIG_FILE
fi
PARAMS=`wc -l < $CONFIG_FILE`
let PARAMS++
if [ $PARAMS -lt "$expected_args" ]; then
  	echo "Usage: autoDeployIni.sh, use -o if you want to proceed if the port is already in use || configure parameters GITHUB_URL BRANCH CONTAINER_TAG LOCAL_PORT CONTAINER_PORT SSH_ADDRESS SSH_CREDENTIALS [ENVIRONMENT_VARS] in autoDeployParams.conf"
  	exit 1
else
	if [ $PARAMS -gt "$expected_args" ]; then 
		for item in ${ENV_VARS[*]}
    	do 
        	ENV_LIST+="-e "
        	ENV_LIST+=$item
        	ENV_LIST+=" "
    	done
		cat autoDeploy.sh | ssh $SSH_ADDR -i $SSH_CREDS "cat > /tmp/autoDeploy.sh ; 
		chmod 755 /tmp/autoDeploy.sh ; /tmp/autoDeploy.sh $GITHUB_URL $BRANCH $CONT_TAG $LOCAL_PORT $CONT_PORT '$OVERRIDE' '$ENV_LIST'"
	else 
		cat autoDeploy.sh | ssh $SSH_ADDR -i $SSH_CREDS "cat > /tmp/autoDeploy.sh ; 
		chmod 755 /tmp/autoDeploy.sh ; /tmp/autoDeploy.sh $GITHUB_URL $BRANCH $CONT_TAG $LOCAL_PORT $CONT_PORT '$OVERRIDE'"
	fi
	exit
fi
