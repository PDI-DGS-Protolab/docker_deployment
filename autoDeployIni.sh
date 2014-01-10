#!/bin/bash
expected_args=7	
if [ "$#" -ne "$expected_args" ]; then
  	echo "Usage: autoDeploy.sh GITHUB_URL BRANCH CONTAINER_TAG LOCAL_PORT CONTAINER_PORT SSH_ADDRESS SSH_CREDENTIALS"
  	exit 1
else
	cat autoDeploy.sh | ssh $6 -i $7 "cat > /tmp/autoDeploy.sh ; chmod 755 /tmp/autoDeploy.sh ; /tmp/autoDeploy.sh $1 $2 $3 $4 $5"
	exit
fi
