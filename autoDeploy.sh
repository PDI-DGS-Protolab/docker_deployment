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
        
        PROCESS_ID=`sudo docker ps | grep $LOCAL_PORT_STRING | awk '{print $1}'`

    	sudo docker stop $PROCESS_ID
        sudo docker rm `docker ps -a -q`
        sudo docker rmi $CONT_TAG
    fi
fi
IFS=/ read -a SPLIT_URL <<< "$GITHUB_URL"
PROJECT_NAME="${SPLIT_URL[${#SPLIT_URL[@]}-1]}"
sudo rm -rf "$PROJECT_NAME"
git clone -b "$BRANCH" "$GITHUB_URL"
cd "$PROJECT_NAME"/DockerSetup

if [[ -z $OVERRIDE ]]; then
    sudo docker build -t $CONT_TAG .
else
    sudo docker build -no-cache -t $CONT_TAG .
fi

if [[ -z "$ENV_VARS" ]]; then
    # without_ENV_VARS
    sudo docker run -d -p "$LOCAL_PORT":"$CONT_PORT" $CONT_TAG
else 
    # with ENV_VARS
    sudo docker run $ENV_VARS -d -p "$LOCAL_PORT":"$CONT_PORT" -t $CONT_TAG 
fi
