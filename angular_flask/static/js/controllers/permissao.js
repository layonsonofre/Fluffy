(function () {
   'use strict';

   angular
   .module('Permissao', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/permissao', {
         templateUrl: '../static/partials/avancado/permissao.html',
         controller: 'PermissaoController',
         controllerAs: 'vm'
      })
   }])
   .controller('PermissaoController', PermissaoController)
   .factory('PermissaoFactory', PermissaoFactory);

   PermissaoController.$inject = ['PermissaoFactory', 'modalService', '$location', 'dataStorage', 'ngToast'];

   function PermissaoController(PermissaoFactory, modalService, $location, dataStorage, ngToast) {
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
         PermissaoFactory.get()
         .then(function (response) {
            vm.permissoes = response.data.result;
         });
      }

      function add() {
         PermissaoFactory.add(vm.form)
         .then(function (response) {
            if (response.data.success === true) {
               get();
               vm.form = null;
               ngToast.success({ content: 'Registro inserido com sucesso'});
            } else {
               ngToast.danger({ content: 'Falha ao inserir o registro' });
            }
         });
      }

      function alt(data) {
         PermissaoFactory.alt(data)
         .then(function (response) {
            if (response.data.success === true) {
               get();
               ngToast.success({ content: 'Registro alterado com sucesso'});
            } else {
               ngToast.danger({ content: 'Falha ao inserir o registro' });
            }
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
            PermissaoFactory.del(entry.id)
            .then(function (response) {
               if (response.data.success === true) {
                  get();
                  ngToast.success({ content: 'Registro excluído com sucesso'});
               } else {
                  ngToast.danger({ content: 'Falha ao excluir o registro' });
               }
            });
         });
      }
   }

   PermissaoFactory.$inject = ['$http', 'Fluffy'];

   function PermissaoFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var PermissaoFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return PermissaoFactory;

      function get() {
         return $http.get(
            _url + '/permissao'
         )
         .then(success)
         .catch(failed);

         function success(response) {
            console.log(response);
            return response;
         }

         function failed(response) {
            return response;
         }
      }

      function add(data) {
         return $http({
            url: _url + '/permissao',
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
            url: _url + '/permissao',
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
            url: _url + '/permissao',
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
