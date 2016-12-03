(function () {
   'use strict';

   angular
   .module('Funcao', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/funcao', {
         templateUrl: '../static/partials/avancado/funcao.html',
         controller: 'FuncaoController',
         controllerAs: 'vm'
      })
   }])
   .controller('FuncaoController', FuncaoController)
   .factory('FuncaoFactory', FuncaoFactory);

   FuncaoController.$inject = ['FuncaoFactory', 'modalService', '$location', 'dataStorage', 'ngToast'];

   function FuncaoController(FuncaoFactory, modalService, $location, dataStorage, ngToast) {
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
      vm.add = add;
      vm.alt = alt;
      vm.del = del;

      get();

      function get() {
         FuncaoFactory.get()
         .then(function (response) {
            if (response.data.success) {
               vm.funcoes = response.data.result;
            } else {
               ngToast.danger({ content: 'Falha ao buscar registros' });
            }
         });
      }

      function add() {
         FuncaoFactory.add(vm.form)
         .then(function (response) {
            vm.form = null;
            get();
         });
      }

      function alt(data) {
         FuncaoFactory.alt(data)
         .then(function (response) {
            get();
         });
      }

      function del(entry) {
         var modalOptions = {
            closeButtonText: 'Cancelar',
            actionButtonText: 'Excluir',
            actionButtonClass: 'btn btn-danger'
         };
         modalService.showModal({}, modalOptions)
         .then(function (result) {
            FuncaoFactory.del(entry.id)
            .then(function (response) {
               get();
            });
         });
      }
   }

   FuncaoFactory.$inject = ['$http', 'Fluffy'];

   function FuncaoFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var FuncaoFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return FuncaoFactory;

      function get(data) {
         data = data || null;
         return $http({
            url: _url + '/funcao',
            method: 'GET',
            params: data
         })
         .then(success)
         .catch(failed);

         function success(response) {
            console.log(response.data.result);
            return response;
         }

         function failed(error) {
            console.error('Failed funcoes: ' + error.data);
         }
      }

      function add(data) {
         return $http({
            url: _url + '/funcao',
            data: data,
            method: 'POST'
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

      function alt(data) {
         return $http({
            url: _url + '/funcao',
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

      function del(id) {
         return $http({
            url: _url + '/funcao',
            data: {
               id: id
            },
            method: 'DELETE'
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
