#!/bin/bash
IFS=/ read -a SPLIT_URL <<< "$1"
PROJECT_NAME="${SPLIT_URL[${#SPLIT_URL[@]}-1]}"
sudo rm -rf "$PROJECT_NAME"
git clone -b "$2" "$1"
cd "$PROJECT_NAME"/DockerSetup
sudo docker build -t $3 .
sudo docker run -d -p "$4":"$5" $3
