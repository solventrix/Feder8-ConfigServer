#!/usr/bin/env bash
set -ex

VERSION=2.0.0
TAG=add-configuration-$VERSION

touch config-server-add-configuration.env

echo "FEDER8_CONFIG_SERVER_HOST=localhost" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_DATASOURCE_HOST=postgres" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_DATASOURCE_PORT=5432" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_DATASOURCE_DATABASE=OHDSI" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_DATASOURCE_USERNAME=honeur" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_DATASOURCE_ADMIN_USERNAME=honeur_admin" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_IDP_URI=https://cas-dev.honeur.org" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_OAUTH_CLIENT_ID=feder8-local" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_OAUTH_CLIENT_SECRET=feder8-local-secret" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_IMAGE_REPOSITORY_HOST=harbor.honeur.org" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_CATALOGUE_URI=https://catalogue-dev.honeur.org" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_THERAPEUTIC_AREA=honeur" >> config-server-add-configuration.env
echo "FEDER8_CONFIG_SERVER_ORGANIZATION=test" >> config-server-add-configuration.env

docker run \
--rm \
--name config-server-add-configuration \
-v "configuration-volume:/home/feder8/config-repo" \
--env-file config-server-add-configuration.env \
--network honeur-net \
feder8/config-server:$TAG

rm -rf config-server-add-configuration.env
