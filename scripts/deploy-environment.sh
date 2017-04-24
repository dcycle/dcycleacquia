#!/bin/bash
#
# Assuming you have the latest version Docker installed, this script will
# fully deploy an environment, initially or incrementally.
#
set -e

docker-compose up -d --build
./scripts/run-command.sh /scripts/deploy.sh

echo ''
echo 'If all went well you can now access your site with username admin and:'
echo 'password admin at:'
echo ''
echo ' => '$(./scripts/login-link.sh)
echo ''
echo 'At this point your environment will not have real data; this might be'
echo 'ok for development; you can import your real database (which you can'
echo 'get at https://insight.acquia.com/site-list and uncompressing it)'
echo 'by typing:'
echo ''
echo ' => ./scripts/import-database.sh /path/to/database.sql'
echo ''
