(function() {
  'use strict';

  angular
    .module('Consulta', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/consulta', {
          templateUrl: '../static/partials/servico/agendar.html',
          controller: 'ConsultaController',
          controllerAs: 'vm'
        })
    }])
    .controller('ConsultaController', ConsultaController);

  ConsultaController.$inject = ['$scope'];

  function ConsultaController($scope) {
    var vm = this;
  }
})()
