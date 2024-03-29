(function () {
   'use strict';

   angular
   .module('Estoque', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/estoque/controle', {
         templateUrl: '../static/partials/estoque/controle.html',
         controller: 'ProdutoController',
         controllerAs: 'vm'
      })
   }])
   .controller('ProdutoController', ProdutoController)
   .factory('ProdutoFactory', ProdutoFactory);

   ProdutoController.$inject = ['ProdutoFactory', 'GrupoItemFactory', 'modalService', '$filter', 'ngToast', '$location', 'dataStorage'];

   function ProdutoController(ProdutoFactory, GrupoItemFactory, modalService, $filter, ngToast, $location, dataStorage) {
      var vm = this;

      if (dataStorage.getUser() == null) {
         $location.path('/login');
         ngToast.danger({content: 'Necessário realizar o login antes de utilizar esta funcionalidade'});
      }

      if (!dataStorage.checkPermission('Venda')) {
         $location.path('/erro');
         ngToast.danger({content: 'Você não tem permissão para acessar esta funcionalidade'});
      }

      vm.form = null;

      vm.get = get;
      vm.add = add;
      vm.alt = alt;
      vm.del = del;
      vm.getGrupos = getGrupos;
      vm.mostrarGrupo = mostrarGrupo;

      get();
      getGrupos();

      function get() {
         ProdutoFactory.get()
         .then(function (response) {
            vm.produtos = response.data.result;
         }, function (response) {
            if (response.data.success != true) {
               ngToast.danger({ content: '<b>Falha ao buscar registros</b>: ' + response.data.message });
            }
         });
      }

      function add() {
         ProdutoFactory.add(vm.form)
         .then(function (response) {
            if (response.data.success != true) {
               ngToast.danger({ content: '<b>Falha ao adicionar o registro</b>: ' + response.data.message });
            } else {
               get();
               ngToast.success({ content: 'Registro adicionado com sucesso' });
            }
         });
      }

      function alt(data) {
         ProdutoFactory.alt(data)
         .then(function (response) {
            if (response.data.success != true) {
               ngToast.danger({ content: '<b>Falha ao alterar o registro</b>: ' + response.data.message });
            } else {
               ngToast.success({ content: 'Registro alterado com sucesso' });
               get();
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
            ProdutoFactory.del(entry.id)
            .then(function (response) {
               if (response.data.success === true) {
                  get();
                  ngToast.success({ content: 'Registro excluído com sucesso' });
               } else {
                  ngToast.danger({ content: 'Falha na excluir o registro' });
               }
            });
         });
      }

      function getGrupos() {
         GrupoItemFactory.get()
         .then(function (response) {
            vm.grupos = response.data.result;
         });
      }

      function mostrarGrupo(entry) {
         if (entry.nome && vm.grupos && vm.grupos.length) {
            var selected = $filter('filter')(vm.grupos, { id: entry.id });
            return selected.length ? selected[0].nome : 'Não configurado';
         } else {
            return entry.nome || 'Não configurado';
         }
      }
   }

   ProdutoFactory.$inject = ['$http', 'Fluffy'];

   function ProdutoFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var ProdutoFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return ProdutoFactory;

      function get() {
         return $http.get(
            _url + '/item'
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
            url: _url + '/item',
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
            url: _url + '/item',
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
            url: _url + '/item',
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
