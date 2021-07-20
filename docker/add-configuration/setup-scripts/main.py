#!/usr/bin/env python
import os
import sh
import logging
import yaml

def update(yaml, nestedKeys, value):
    if len(nestedKeys) > 1:
        key = nestedKeys.pop(0)
        update(yaml.get(key, {}), nestedKeys, value)
    else:
        if nestedKeys[0] in yaml:
            yaml[nestedKeys[0]] = value
    return yaml

if __name__ == "__main__":
    therapeuticArea = os.environ.get('FEDER8_CONFIG_SERVER_THERAPEUTIC_AREA', 'honeur').lower()
    logLevel = os.environ.get('LOG_LEVEL', 'INFO').upper()
    logging.basicConfig(level=logLevel)

    logging.info("Creating configuration...")
    currentDirectory = os.getcwd()
    repo = 'config-repo'
    filename = 'feder8-config-' + therapeuticArea + '.yaml'

    if not os.path.exists(repo + "/" + filename):
        with open("feder8-config.yaml",'r') as file:
            data = file.read()
        with open(repo + "/" + filename,'w') as file:
            file.write(data)

    feder8Environs = {}
    for k, v in os.environ.items():
        if(k.startswith('FEDER8')):
            feder8Environs[k] = v

    with open(repo + "/" + filename, 'r') as file:
        yamlData = yaml.safe_load(file)
        for k, v in feder8Environs.items():
            nestedKeys = [x.lower() for x in k.split('_')]
            update(yamlData, nestedKeys, v)

    with open(repo + "/" + filename, 'w') as file:
        yaml.dump(yamlData, file)

    sh.cd(repo)
    sh.git.init()

    sh.git.add(filename)
    try:
        sh.git.commit(m='update configuration for ' + therapeuticArea)
    except:
        pass
    logging.info('Done creating configuration')
