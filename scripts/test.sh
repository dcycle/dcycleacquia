#!/bin/bash
#
# Run automated tests.
# Can be run on Circle CI.
#

set -e

docker run -ti -v $(pwd):/app phpunit/phpunit:5.7.12 --group custom
