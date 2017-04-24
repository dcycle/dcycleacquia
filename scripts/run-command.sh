#!/bin/bash
#
# Run a command on the Drupal service.
#
# We need to go through some hoops because CircleCI does not accept the --rm
# parameter for docker-compose run.
#

set -e

if [ -f './settings.source.sh' ]; then
  source ./settings.source.sh;
fi

if [ -z "$RUNDRUPAL" ]; then
  docker-compose run --rm drupal /bin/bash -c "$1"
else
  "$RUNDRUPAL" "$1"
fi
