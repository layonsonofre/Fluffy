(function() {
  'use strict';

  angular
    .module('Configuracao', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/configuracao', {
          templateUrl: '../static/partials/avancado/configuracao.html',
          controller: 'ConfiguracaoController',
          controllerAs: 'vm'
        })
    }])
    .controller('ConfiguracaoController', ConfiguracaoController)
    .factory('ConfiguracaoFactory', ConfiguracaoFactory);

  ConfiguracaoController.$inject = ['ConfiguracaoFactory'];

  function ConfiguracaoController(ConfiguracaoFactory) {
    var vm = this;
    vm.form = null;

    vm.get = get;
    vm.alt = alt;

    get();

    function get() {
      ConfiguracaoFactory.get()
        .then(function(response) {
          vm.form = response.data.result;
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data) {
      ConfiguracaoFactory.alt(data)
        .then(function(response) {
          get();
        }, function(response) {
          vm.status = response.message
        });
    }
  }

  ConfiguracaoFactory.$inject = ['$http', 'Fluffy'];

  function ConfiguracaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var ConfiguracaoFactory = {
      get: get,
      alt: alt
    };
    return ConfiguracaoFactory;

    function get() {
      return $http.get(
          _url + '/configuracao'
        )
        .then(success)
        .catch(failed);

      function success(response) {
        console.log(response);
        return response;
      }

      function failed(response) {
        console.error('Failed: ' + JSON.stringify(response));
      }
    }

    function alt(data) {
      console.log('UPDATING: ' + JSON.stringify(data));
      return $http({
          url: _url + '/configuracao',
          data: data,
          method: 'PUT'
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response;
      }

      function failed(response) {
        console.error('Failed: ' + JSON.stringify(response));
      }
    }
  }
})()
