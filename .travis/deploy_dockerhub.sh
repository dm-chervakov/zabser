#!/bin/bash

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
docker tag $DOCKER_NAME_IMAGE $DOCKER_USER/$DOCKER_NAME_IMAGE
docker push $DOCKER_USER/$DOCKER_NAME_IMAGE

