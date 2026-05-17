#!/bin/bash

docker pull $ECR_REPO:latest

docker stop backend || true
docker rm backend || true

docker run -d -p 8080:8080 --name backend $ECR_REPO:latest