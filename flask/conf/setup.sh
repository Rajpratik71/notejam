#!/bin/bash

# Let's pretend this just does everything

# Install docker

# Install terraform

# Run terraform init

# Build base docker image

docker build -t notejam_base

IMAGE_ID=`docker images | grep -i notejam_base | awk '{print $3}'`

# There was some weirdness with string quotes in the output.

# TODO: Make this cleaner...

URI_STRING=`aws ecr describe-repositories | grep -i repositoryUri | awk '{print $2}' | sed -e 's/^"//' -e 's/"$//'`

ECR_URI=`echo $URI_STRING | rev | cut -c 3- | rev`

docker tag $IMAGE_ID $ECR_URI2

# This command might fail if a lot of time has passed and you are logged out of ecr.

# If it fails it should tell you what command to run to log back in. Do it and re-run the script.

docker push $ECR_URI

# Instruct user to set up env variables. Terraform will need several parameters to do its magic.


