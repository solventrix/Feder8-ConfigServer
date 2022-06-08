#!/usr/bin/env bash
set -eux

VERSION=2.0.2
TAG=$VERSION
export REGISTRY=harbor-uat.honeur.org
export REPOSITORY=honeur
export REGISTRY_USERNAME=admin
export REGISTRY_PASSWORD=harbor_password

./mvnw clean test jib:build -DskipITs
docker buildx build --rm --platform linux/amd64,linux/arm64 --build-arg CONFIG_SERVER_VERSION=$VERSION --build-arg REGISTRY=$REGISTRY --build-arg REPOSITORY=$REPOSITORY --push -f "Dockerfile" -t $REGISTRY/$REPOSITORY/config-server:$TAG .
