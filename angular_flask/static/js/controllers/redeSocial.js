(function() {
  'use strict';

  angular
    .module('RedeSocial', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/redesSociais', {
          templateUrl: '../static/partials/avancado/redeSocial.html',
          controller: 'RedeSocialController',
          controllerAs: 'vm'
        })
    }])
    .controller('RedeSocialController', RedeSocialController)
    .factory('RedeSocialFactory', RedeSocialFactory);

  RedeSocialController.$inject = ['RedeSocialFactory'];

  function RedeSocialController(RedeSocialFactory) {
    var vm = this;

    vm.get = get;
    vm.add = add;

    get();

    function get() {
      RedeSocialFactory.get()
        .then(function(response) {
          vm.redesSociais = response;
        }, function(response) {
          vm.status = 'Failed to load socials networks: ' + error.message;
        });
    }

    function addRedeSocial() {
      RedeSocial.add(vm.form.redeSocial)
        .then(function(response) {
          console.log(response);
        }, function(response) {
          vm.status = 'Failed ' + error.message;
        })
    }
  }

  RedeSocialFactory.$inject = ['$http', 'Fluffy'];

  function RedeSocialFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var RedeSocialFactory = {
      get: get,
      add: add
    };
    return RedeSocialFactory;

    function get() {
      return $http.get(_url + '/redeSocial')
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getRedesSociais: ' + error.data);
      }
    }

    function add(data) {
      console.log('SAVING: ' + JSON.stringify(data));
      return $http({
          method: 'POST',
          url: _url + '/redeSocial',
          data: data
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
