#!/usr/bin/env python
import os
import sh
import logging

if __name__ == "__main__":
    host = os.environ.get('FEDER8_CONFIG_SERVER_HOST', 'localhost')
    datasourceHost = os.environ.get('FEDER8_CONFIG_SERVER_DATASOURCE_HOST', 'postgres')
    datasourcePort = os.environ.get('FEDER8_CONFIG_SERVER_DATASOURCE_PORT', '5432')
    datasourceDatabase = os.environ.get('FEDER8_CONFIG_SERVER_DATASOURCE_DATABASE', 'OHDSI')
    datasourceUsername = os.environ.get('FEDER8_CONFIG_SERVER_DATASOURCE_USERNAME', 'honeur')
    datasourceAdminUsername = os.environ.get('FEDER8_CONFIG_SERVER_DATASOURCE_ADMIN_USERNAME', 'honeur_admin')
    identityProviderUri = os.environ.get('FEDER8_CONFIG_SERVER_IDP_URI', 'https://cas.honeur.org')
    oauthClientId = os.environ.get('FEDER8_CONFIG_SERVER_OAUTH_CLIENT_ID', 'feder8-oidc-local-client')
    oauthClientSecret = os.environ.get('FEDER8_CONFIG_SERVER_OAUTH_CLIENT_SECRET', 'feder8-oidc-local-client')
    imageRepositoryHost = os.environ.get('FEDER8_CONFIG_SERVER_IMAGE_REPOSITORY_HOST', 'harbor.honeur.org')
    catalogueUri = os.environ.get('FEDER8_CONFIG_SERVER_CATALOGUE_URI', 'https://catalogue.honeur.org')
    therapeuticArea = os.environ.get('FEDER8_CONFIG_SERVER_THERAPEUTIC_AREA', 'honeur').lower()
    organization = os.environ.get('FEDER8_CONFIG_SERVER_ORGANIZATION', 'janssen').lower()
    logLevel = os.environ.get('LOG_LEVEL', 'INFO').upper()
    logging.basicConfig(level=logLevel)

    logging.info("Creating configuration...")
    with open("feder8-config.yaml",'r') as file:
        data = file.read()
        data = data.replace('FEDER8_CONFIG_SERVER_HOST', host)
        data = data.replace('FEDER8_CONFIG_SERVER_DATASOURCE_HOST', datasourceHost)
        data = data.replace('FEDER8_CONFIG_SERVER_DATASOURCE_PORT', datasourcePort)
        data = data.replace('FEDER8_CONFIG_SERVER_DATASOURCE_DATABASE', datasourceDatabase)
        data = data.replace('FEDER8_CONFIG_SERVER_DATASOURCE_USERNAME', datasourceUsername)
        data = data.replace('FEDER8_CONFIG_SERVER_DATASOURCE_ADMIN_USERNAME', datasourceAdminUsername)
        data = data.replace('FEDER8_CONFIG_SERVER_IDP_URI', identityProviderUri)
        data = data.replace('FEDER8_CONFIG_SERVER_OAUTH_CLIENT_ID', oauthClientId)
        data = data.replace('FEDER8_CONFIG_SERVER_OAUTH_CLIENT_SECRET', oauthClientSecret)
        data = data.replace('FEDER8_CONFIG_SERVER_IMAGE_REPOSITORY_HOST', imageRepositoryHost)
        data = data.replace('FEDER8_CONFIG_SERVER_CATALOGUE_URI', catalogueUri)

    directory = 'config-repo'
    filename = 'feder8-config-' + therapeuticArea + '-' + organization + '.yaml'

    sh.cd(directory)
    sh.git.init()
    if not os.path.exists(filename):
        with open(filename,'w') as file:
            file.write(data)
        sh.git.add(filename)
        sh.git.commit(m='add initial configuration for ' + therapeuticArea + ' and ' + organization + ' connection')
    logging.info('Done creating configuration')