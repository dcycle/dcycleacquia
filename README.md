The Dcycle method for developing with Acquia cloud
=====

 * To keep things simple and avoid a build server, we are keeping our artefacts in git.
 * The only local requirements are Docker and docker-compose.
 * Anything which requires specific software is done in a Docker container. For example: processing SASS, running PHPUnit tests.
 * We do not require a database for development, you can use a [site deployment module](http://blog.dcycle.com/blog/68).
 * Two origins: acquia and github.

Creating a new local environment
-----

    ./scripts/deploy-environment.sh

Getting a login link to your local environment
-----

    ./scripts/login-link.sh

Updating an existing local environment
-----

    ./scripts/deploy-environment.sh

Killing a local environment but keeping data
-----

    docker-compose down

Killing a local environment and data
-----

    docker-compose down -v

Exporting local config to code
-----

For example, new content types, fields, views...

    ./scripts/export-config-to-code.sh

Importing the database
-----

You can generally develop without the database, but if you need it:

    ./scripts/import-database.sh /path/to/database.sql

Updating an Acquia environment
-----

    git push origin master

Then log into the Acquia system and run:

    drush @dcycleacquia.dev en -y dcycleacquia_deploy
    drush @dcycleacquia.dev updb -y
    drush @dcycleacquia.dev cim -y vcs
