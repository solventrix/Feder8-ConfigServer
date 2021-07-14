#!/usr/bin/env bash
set -eux

VERSION=2.0.0
TAG=$VERSION

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) -v $HOME/.m2:/root/.m2 -v $(pwd):/opt/app openjdk:11-jdk-slim-buster sh -c "set -eux; cd /opt/app; ./mvnw clean test jib:dockerBuild -DskipITs; chown -R $(id -u) /opt/app; chown -R $(id -u) /root/.m2"
docker build --rm -f "Dockerfile" -t feder8/config-server:$TAG "."
