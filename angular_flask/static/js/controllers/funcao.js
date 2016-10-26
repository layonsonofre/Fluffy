(function() {
  'use strict';

  angular
    .module('Funcao', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/funcao', {
          templateUrl: '../static/partials/avancado/funcao.html',
          controller: 'FuncaoController',
          controllerAs: 'Funcao'
        })
    }])
    .controller('FuncaoController', FuncaoController)
    .factory('FuncaoFactory', FuncaoFactory);

  FuncaoController.$inject = ['$scope', 'FuncaoFactory'];

  function FuncaoController($scope, FuncaoFactory) {
    var vm = this;
    FuncaoFactory.get().then(function(response) {
      vm.funcoes = response;
    }, function(response) {
      console.log('Failed to load funcao' + response);
    })
  }

  FuncaoFactory.$inject = ['$http', 'Fluffy'];

  function FuncaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var FuncaoFactory = {
      get: get
    };
    return FuncaoFactory;

    function get() {
      return $http.get(_url + '/funcao')
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed funcoes: ' + error.data);
      }
    }
  }
})()
