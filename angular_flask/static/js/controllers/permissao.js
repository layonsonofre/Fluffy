'use strict';

angular
   .module('Permissao', [])
   .config(['$routeProvider', function($routeProvider) {
      $routeProvider
         .when('/permissao', {
            templateUrl: '../static/partials/avancado/permissao.html',
            controller: 'PermissaoController',
            controllerAs: 'Permissao'
         })
   }])
   .controller('PermissaoController', PermissaoController)
   .factory('PermissaoFactory', PermissaoFactory);

PermissaoController.$inject = ['$scope', 'PermissaoFactory'];

function PermissaoController($scope, PermissaoFactory) {
   var vm = this;

   PermissaoFactory.get().then(function(response) {
      console.log(response);
      vm.permissoes = response;
   }, function(response) {
      console.log('Failed to load permissao');
   });

}

PermissaoFactory.$inject = ['$http', 'Fluffy'];

function PermissaoFactory($http, Fluffy) {
   var _url = Fluffy.urlBase;
   var PermissaoFactory = {
      get: get
   };
   return PermissaoFactory;

   function get() {
      return $http.get(_url + '/permissao')
         .then(success)
         .catch(failed);

      function success(response) {
         return response.data.result;
      }

      function failed(error) {
         console.error('Failed permissao: ' + error.data);
      }
   }
}
