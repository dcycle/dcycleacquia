The Dcycle method for developing with Acquia cloud
=====

 * To keep things simple and avoid a build server, we are keeping our artefacts in git.
 * The only local requirements are Docker and docker-compose.
 * Anything which requires specific software is done in a Docker container. For example: processing SASS, running PHPUnit tests.
 * We do not require a database for development, you can use a [site deployment module](http://blog.dcycle.com/blog/68).

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

Troubleshooting
-----

On or before April 28th, 2017, Acquia seems to have added this code to their initial settings.php:

    // Initialize install_profile to the Drupal distribution name detected by the Acquia Cloud installation process.
    if (class_exists('Drupal') && defined('Drupal::CORE_COMPATIBILITY') && Drupal::CORE_COMPATIBILITY == '8.x') {
     if (!isset($settings['install_profile'])) {
        $settings['install_profile'] = 'lightning';
      }
    }

If you are getting "Cannot use object of type stdClass as array in /var/www/html/core/includes/install.inc on line 284", you can delete that entire block of code, and instead put in settings.php:

    $settings['install_profile'] = 'YOUR-INSTALL-PROFILE';

Where YOUR-INSTALL-PROFILE is lightning or standard.
