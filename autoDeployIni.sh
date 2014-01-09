#!/bin/bash
expected_args=5	
if [ "$#" -ne "$expected_args" ]; then
  	echo "Usage: autoDeploy.sh GITHUB_URL BRANCH CONTAINER_TAG SSH_ADDRESS SSH_CREDENTIALS"
  	exit 1
else
	cat autoDeploy.sh | ssh $4 -i $5 "cat > /tmp/autoDeploy.sh ; chmod 755 /tmp/autoDeploy.sh ; /tmp/autoDeploy.sh $1 $2 $3"
	exit
fi
