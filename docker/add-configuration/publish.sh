#!/usr/bin/env bash
set -eux

VERSION=2.0.0
TAG=update-configuration-$VERSION

docker tag feder8/config-server:$TAG $THERAPEUTIC_AREA_URL/$THERAPEUTIC_AREA/config-server:$TAG
docker push $THERAPEUTIC_AREA_URL/$THERAPEUTIC_AREA/config-server:$TAG
