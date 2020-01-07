#!/usr/bin/bash
#####################################################
# Description: Purpose of script to automated way to pull static content, create docker build and start docker container.
# Writer: Hemant Bhavsar
# Version: 0.0.1
#####################################################

PWD=$(pwd)
GIT=git
DOCKER=docker
WWW_LOCATION=~/www

if ! command -v $GIT >/dev/null ; then
  echo "ERROR: git Command Doesn't Exists"
  exit 1
fi

if ! command -v $DOCKER >/dev/null ; then
  echo "ERROR: docker Command Doesn't Exists"
  exit 1
fi

IMAGE_CHECK=$(docker images |grep site|awk '{print $3}')

if [ ! -z $IMAGE_CHECK ]; then
  echo "WARNING: Image is Already Exists.Deleting Image to allow building new image"
  docker ps -a |grep $IMAGE_CHECK|awk '{print $1}'|xargs -i docker stop {} > /dev/null
  docker ps -a |grep $IMAGE_CHECK|awk '{print $1}'|xargs -i docker rm {} > /dev/null
  docker rmi $IMAGE_CHECK > /dev/null
fi


#### Source Code Git Repo

if [ -d $WWW_LOCATION ]; then
  echo "WARNING: Deleting www dir to allow cloning new code"
  rm -fr $WWW_LOCATION
fi

echo "INFO: Cloning Static Content Git Repo"
git clone https://github.com/whitesunset/wannacrypt_balance.git $WWW_LOCATION > /dev/null

if [[ $? > 0 ]]; then
  echo "ERROR: Unable to Pull Static/UI Contents"
  exit 1
fi
echo "INFO: Successfully Clone GIT Repo"

# Build Docker Image 
echo "INFO: Building Docker Image"
docker build -t site -f $PWD/Dockerfile . >/dev/null

if [[ $? > 0 ]]; then
  echo "ERROR: Unable to Build Docker Images"
  exit 1
fi
echo "INFO: Successfully Built Docker Image"

IMAGE_ID=$(docker images |grep site|awk '{print $3}')

echo "INFO: Docker Image starting"
docker run -idt -v $WWW_LOCATION:/www -p 80:80 $IMAGE_ID

if [[ $? > 0 ]]; then
  echo "ERROR: Unable to Start Docker Container"
  exit 1
fi

echo "INFO: Docker Image started"
