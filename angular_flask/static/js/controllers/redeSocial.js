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

  RedeSocialController.$inject = ['$scope', 'RedeSocialFactory'];

  function RedeSocialController($scope, RedeSocialFactory) {
    var vm = this;

    RedeSocialFactory.get().then(function(response) {
      console.log('RedeSocial: ' + response);
      vm.redesSociais = response;
    }, function(response) {
      vm.status = 'Failed to load socials networks: ' + error.message;
    })
  }

  RedeSocialFactory.$inject = ['$http', 'Fluffy'];

  function RedeSocialFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var RedeSocialFactory = {
      get: get
    };
    return RedeSocialFactory;

    function get() {
      return $http.get(_url + '/redeSocial')
        .then(success)
        .catch(failed);

      function success(response) {
        console.log(response.data);
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getRedesSociais: ' + error.data);
      }
    }
  }
})()
