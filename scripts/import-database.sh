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

docker cp "$1" $(docker-compose ps -q web):/sql.sql
# Drop all existing tables in the DB.
docker exec "$(docker-compose ps -q web)" /bin/bash -c "drush sql-drop -y"
echo '[notice] About to import the database, this might take about'
echo '         10 to 20 minutes.'
docker-compose exec web /bin/bash -c "drush sqlc < /sql.sql"
# The temporary path on the target database may be set to something that
# does not exist locally.
./scripts/dev-environment/drush.sh "vset file_temporary_path '/tmp'"
# at_tools is a simple module which recreates files required by the
# adaptivetheme themes on cache clear.
./scripts/dev-environment/drush.sh "-y en at_tools"
./scripts/dev-environment/drush.sh "cc all"

echo 'If all went well you can now access your site at:'
echo ''
echo ' => '$(./scripts/dev-environment/uli.sh)
echo ''
