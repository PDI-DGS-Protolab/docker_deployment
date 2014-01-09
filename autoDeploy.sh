#!/bin/bash
searching="Dockerfile"
if echo "$1" | grep -q "$searching"; then
  echo "matched"
  newString=raw
  wget `sed "s/blob/$newString/g" <<<"$1"`
else
  echo "no match"
  wget $1/raw/$2/Dockerfile
fi
sudo docker build -t $3 .
sudo docker run -d -p 8000:8000 $3
