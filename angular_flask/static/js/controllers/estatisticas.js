(function() {
  'use strict';

  angular
    .module('Estatisticas', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/estatisticas', {
          templateUrl: '../static/partials/estatisticas.html',
          controller: 'EstatisticasController',
          controllerAs: 'vm'
        })
    }])
    .controller('EstatisticasController', EstatisticasController)
    .factory('EstatisticasFactory', EstatisticasFactory);

  EstatisticasController.$inject = ['$scope', 'EstatisticasFactory'];

  function EstatisticasController($scope, EstatisticasFactory) {
    var vm = this;
  }

  EstatisticasFactory.$inject = ['$http', 'Fluffy'];

  function EstatisticasFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
  }

})()
