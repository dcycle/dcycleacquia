<?php

/**
 * @file
 * Test Singleton.
 */

use Drupal\dcycleacquia_custom\Singleton;

require_once './containers/drupal-custom-modules/dcycleacquia_custom/src/Singleton.php';

/**
 * Dummy Singleton for testing.
 */
class SingletonObject {

  use Singleton;

}

/**
 * Test Singleton.
 *
 * @group dcycleacquia
 */
class SingletonTest extends \PHPUnit_Framework_TestCase {

  /**
   * Test Singleton::instance().
   *
   * @covers ::instance().
   */
  public function testInstance() {
    $this->assertTrue(SingletonObject::instance() === SingletonObject::instance(), 'Singleton works correctly: instance is the same no matter how many times it is called.');
  }

}
