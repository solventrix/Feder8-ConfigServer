#!/usr/bin/env bash
set -eux

VERSION=2.0.0
TAG=update-configuration-$VERSION

docker build --pull --rm -f "Dockerfile" -t feder8/config-server:$TAG "."
