#!/bin/bash
GITHUB_URL="$1";BRANCH="$2";CONT_TAG="$3";LOCAL_PORT="$4";CONT_PORT="$5";OVERRIDE="$6";ENV_VARS="$7";

COUNT=`sudo lsof -i ":$LOCAL_PORT" | wc -c`
ZERO=0

if [[ "$COUNT" -ne $ZERO ]]; then
	if [[ -z $OVERRIDE ]]; then
    	echo "The port $LOCAL_PORT is already in use. To kill the process, the image and deploy execute with option -o."
    	exit 1
    else
    	#kill process and proceed
    	LOCAL_PORT_STRING=":$LOCAL_PORT->"
        
        PROCESS_IMAGE=`sudo docker ps | grep $LOCAL_PORT_STRING | awk '{print $1, $2}'`

        PROCESS_IMAGE_ARRAY=($PROCESS_IMAGE)
        PROCESS_ID=${PROCESS_IMAGE_ARRAY[0]}
        IMAGE_ID=${PROCESS_IMAGE_ARRAY[1]}
    	sudo docker stop $PROCESS_ID
        sudo docker rm `docker ps -a -q`
        sudo docker rmi $IMAGE_ID
    fi
fi
IFS=/ read -a SPLIT_URL <<< "$GITHUB_URL"
PROJECT_NAME="${SPLIT_URL[${#SPLIT_URL[@]}-1]}"
sudo rm -rf "$PROJECT_NAME"
git clone -b "$BRANCH" "$GITHUB_URL"
cd "$PROJECT_NAME"/DockerSetup
sudo docker build -t $CONT_TAG .
if [[ -z "$ENV_VARS" ]]; then
	sudo docker run -d -p "$LOCAL_PORT":"$CONT_PORT" $CONT_TAG
else 
	sudo docker run -d -p "$LOCAL_PORT":"$CONT_PORT" $CONT_TAG -e "$ENV_VARS"
fi
