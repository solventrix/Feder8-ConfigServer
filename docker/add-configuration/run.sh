#!/usr/bin/env bash
set -ex

VERSION=2.0.0
TAG=add-configuration-$VERSION

touch config-server-add-configuration.env

echo "FEDER8_LOCAL_HOST_NAME=localhost" >> config-server-add-configuration.env
echo "FEDER8_LOCAL_DATASOURCE_HOST=postgres" >> config-server-add-configuration.env
echo "FEDER8_LOCAL_DATASOURCE_PORT=5432" >> config-server-add-configuration.env
echo "FEDER8_LOCAL_DATASOURCE_NAME=OHDSI" >> config-server-add-configuration.env
echo "FEDER8_LOCAL_DATASOURCE_USERNAME=honeur" >> config-server-add-configuration.env
echo "FEDER8_LOCAL_DATASOURCE_ADMIN-USERNAME=honeur_admin" >> config-server-add-configuration.env
echo "FEDER8_CENTRAL_SERVICE_OAUTH-ISSUER-URI=https://cas-dev.honeur.org" >> config-server-add-configuration.env
echo "FEDER8_CENTRAL_SERVICE_OAUTH-CLIENT-ID=feder8-local" >> config-server-add-configuration.env
echo "FEDER8_CENTRAL_SERVICE_OAUTH-CLIENT-SECRET=feder8-local-secret" >> config-server-add-configuration.env
echo "FEDER8_CENTRAL_SERVICE_IMAGE-REPO=harbor.honeur.org" >> config-server-add-configuration.env
echo "FEDER8_CENTRAL_SERVICE_CATALOGUE-BASE-URI=https://catalogue-dev.honeur.org" >> config-server-add-configuration.env
echo "FEDER8_LOCAL_THERAPEUTIC_AREA=honeur" >> config-server-add-configuration.env
echo "FEDER8_LOCAL_ORGANIZATION=test" >> config-server-add-configuration.env

docker run \
--rm \
--name config-server-add-configuration \
-v "configuration-volume:/home/feder8/config-repo" \
--env-file config-server-add-configuration.env \
--network honeur-net \
feder8/config-server:$TAG

rm -rf config-server-add-configuration.env
