#!/usr/bin/env bash

if [ "$1" = 'run-script' ]; then
  set -e
  if [ -f "/var/lib/shared/honeur.env" ]; then
    source /var/lib/shared/honeur.env
    export $(cut -d= -f1 /var/lib/shared/honeur.env)
  fi

  exec python3 -u main.py
fi

exec "$@"