(function() {
  'use strict';

  angular
    .module('Index', [])
    .controller('IndexController', IndexController);

  IndexController.$inject = ['$rootScope'];

  function IndexController($rootScope) {
    $rootScope.hideMenu = false;
    $rootScope.bodyBackground = '';
  }
})()
