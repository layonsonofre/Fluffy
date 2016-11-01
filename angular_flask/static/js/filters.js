(function() {
  'use strict';

  angular.module('FluffyFilters', []).filter('uppercase', function() {
    return function(input) {
      return input.toUpperCase();
    }
  });

})()
