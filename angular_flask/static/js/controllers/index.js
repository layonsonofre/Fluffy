(function () {
   'use strict';

   angular
   .module('Index', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/overview', {
         templateUrl: '../static/partials/overview.html',
         controller: 'IndexController',
         controllerAs: 'vm'
      });
   }])
   .controller('IndexController', IndexController);

   IndexController.$inject = ['$rootScope', 'dataStorage', '$location'];

   function IndexController($rootScope, dataStorage, $location) {
      if (dataStorage.getUser() == null) {
         $location.path('/login');
      }
      $rootScope.hideMenu = false;
      $rootScope.bodyBackground = '';
   }
})()
