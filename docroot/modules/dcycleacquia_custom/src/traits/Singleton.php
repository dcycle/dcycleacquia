<?php

namespace Drupal\dcycleacquia_custom;

/**
 * Implements the Singleton design pattern.
 */
trait Singleton {

  /**
   * Interal instance variable used with the instance() method.
   *
   * @var object
   */
  static private $instance;

  /**
   * Implements the Singleton design pattern.
   *
   * Only one instance of the Concord class should exist per execution.
   *
   * @return Concord
   *   The single instance of the concord class.
   */
  static public function instance() {
    // See http://stackoverflow.com/questions/15443458
    $class = get_called_class();

    if (!$class::$instance) {
      $class::$instance = new $class();
    }
    return $class::$instance;
  }

}
