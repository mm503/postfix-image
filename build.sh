#!/bin/bash

VER=$(grep FROM Dockerfile | cut -d':' -f2 | cut -d'-' -f1)
TAG="${VER}.$(date +%Y%m%d)"
IMG_NAME="$1"

docker build --no-cache -t "$IMG_NAME:$TAG" .
docker tag "$IMG_NAME:$TAG" "$IMG_NAME:latest"
