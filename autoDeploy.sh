#!/bin/bash
GITHUB_URL="$1";BRANCH="$2";CONT_TAG="$3";LOCAL_PORT="$4";CONT_PORT="$5";ENV_VARS="$6";

COUNT=`lsof -i ":$1" | wc -c`
ZERO=0

if [[ "$COUNT" -eq $ZERO ]]; then
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
else
    echo "$LOCAL_PORT is already in use."
fi
