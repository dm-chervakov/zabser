#!/bin/bash

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
docker tag zabser $DOCKER_USER/zabser
docker push $DOCKER_USER/zabser

