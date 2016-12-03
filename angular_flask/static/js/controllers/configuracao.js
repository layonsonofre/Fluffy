(function () {
   'use strict';

   angular
   .module('Configuracao', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/configuracao', {
         templateUrl: '../static/partials/avancado/configuracao.html',
         controller: 'ConfiguracaoController',
         controllerAs: 'vm'
      })
   }])
   .controller('ConfiguracaoController', ConfiguracaoController)
   .factory('ConfiguracaoFactory', ConfiguracaoFactory);

   ConfiguracaoController.$inject = ['ConfiguracaoFactory', 'ngToast', '$location', 'dataStorage'];

   function ConfiguracaoController(ConfiguracaoFactory, ngToast, $location, dataStorage) {
      var vm = this;

      if (dataStorage.getUser() == null) {
         $location.path('/login');
         ngToast.danger({content: 'Necessário realizar o login antes de utilizar esta funcionalidade'});
      }

      if (!dataStorage.checkPermission('Cadastro')) {
         $location.path('/erro');
         ngToast.danger({content: 'Você não tem permissão para acessar esta funcionalidade'});
      }
      vm.form = null;

      vm.get = get;
      vm.alt = alt;

      get();

      function get() {
         ConfiguracaoFactory.get()
         .then(function (response) {
            if (response.data.success === true) {
               vm.form = response.data.result;
            } else {
               ngToast.danger({ content: 'Falha: ' + response.data.message });
            }
         });
      }

      function alt() {
         ConfiguracaoFactory.alt(vm.form)
         .then(function (response) {
            if (response.data.success === true) {
               ngToast.success({content: 'Registro alterado com sucesso'});
               get();
            } else {
               ngToast.danger({content: 'Falha na alteração do registro: ' + response.data.message});
            }
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
            return response;
         }

         function failed(response) {
            return response;
         }
      }

      function alt(data) {
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
            return response;
         }
      }
   }
})()
