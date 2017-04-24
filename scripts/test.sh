#!/bin/bash
#
# Run automated tests.
# Can be run on Circle CI.
#

set -e

BASEPATH="$(pwd)"
EXPECTEDLOCATION='tests/'
SCRIPTNAME="$(basename "$0")"
if [ ! -f "$BASEPATH"/"$EXPECTEDLOCATION""$SCRIPTNAME" ]; then
  echo -e "[error] To run: cd /path/to/dcycle-metrics/;"
  echo -e "                ./$EXPECTEDLOCATION$SCRIPTNAME"
  exit 1;
fi

# Get environment and host variables.
source ./scripts/lib/environment-variables.source.sh

./tests/fast-tests.sh
./scripts/deploy.sh
./scripts/run-drupal.sh 'drush cron'

echo 'Selftest after an initial deployment.'
(exit "$(./scripts/run-drupal.sh 'drush eval "echo dcycleacquia_deploy_selftest()"')")

./scripts/deploy.sh

echo 'Selftest after an incremental deployment.'
(exit "$(./scripts/run-drupal.sh 'drush eval "echo dcycleacquia_deploy_selftest()"')")

echo 'Make sure we can interact with the frontend.'
./tests/lib/end-to-end-tests.sh

./kill.sh
