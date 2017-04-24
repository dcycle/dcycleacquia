#!/bin/bash
#
# Import a database to the existing site
#
set -e

if [ ! -f "$1" ]; then
  echo 'Please provide a path to your uncompressed sql database as an'
  echo 'argument.'
  exit 1
fi

docker cp "$1" $(docker-compose ps -q drupal):/sql.sql
# Drop all existing tables in the DB.
docker exec "$(docker-compose ps -q drupal)" /bin/bash -c "drush sql-drop -y"
echo '[notice] About to import the database, this might take about'
echo '         10 to 20 minutes.'
docker-compose exec drupal /bin/bash -c "drush sqlc < /sql.sql"
./scripts/run-command.sh "drush cr"

echo 'If all went well you can now access your site at:'
echo ''
echo ' => '$(./scripts/login-link.sh)
echo ''
