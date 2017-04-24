#!/bin/bash
#
# Get a one-time login link to your development environment.
# Use your own IP address or localhost instead of 0.0.0.0.
#

./scripts/run-command.sh "drush -l http://$(docker-compose port drupal 80) uli"
