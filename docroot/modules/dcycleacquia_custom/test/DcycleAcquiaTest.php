<?php

namespace Drupal\dcycleacquia_custom;

/**
 * Represents the environment.
 *
 * The environment contains a number of websites.
 */
class DcycleAcquia {

  use Singleton;

  /**
   * Creates a new website.
   *
   * @param array $info
   *   An associative array with the following optional keys:
   *   compulstory.
   *     website_title
   *     uuid.
   *
   * @return Drupal\dcycleacquia_custom\Website
   *   The resulting website.
   *
   * @throws Exception
   */
  public function createWebsite($info = []) {
    // Start by creating a Website object to hold our new website.
    $website = new Website();
    $website->createNew($info);
    return $website;
  }

  /**
   * Fetch a website by its UUID.
   *
   * @param string $uuid
   *   A uuid.
   *
   * @return Drupal\dcycleacquia_custom\Website
   *   A website.
   *
   * @throws Exception
   */
  public function loadWebsiteByUuid($uuid) {
    // Start by creating a Website object to hold our new website.
    $website = new Website();
    $website->loadByUuid($uuid);
    return $website;
  }

}
