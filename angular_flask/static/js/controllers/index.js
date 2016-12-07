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

   IndexController.$inject = ['$rootScope', 'dataStorage', '$location', '$http'];

   function IndexController($rootScope, dataStorage, $location, $http) {
      if (dataStorage.getUser() == null) {
         $location.path('/login');
      } else {
         let _token = dataStorage.getUser().token;
         $http.defaults.headers.common.Authorization = "Bearer " + _token;
         dataStorage.getPermissoes();
      }
      $rootScope.hideMenu = false;
      $rootScope.bodyBackground = '';
   }
})()
