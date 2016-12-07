(function () {
   'use strict';

   angular
   .module('Servico', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/servico/cadastro', {
         templateUrl: '../static/partials/servico/cadastro.html',
         controller: 'ServicoController',
         controllerAs: 'vm'
      });
   }])
   .controller('ServicoController', ServicoController)
   .factory('ServicoFactory', ServicoFactory);

   ServicoController.$inject = ['ServicoFactory', 'calendarConfig', 'modalService', 'dataStorage', '$filter', 'ngToast', '$location'];

   function ServicoController(ServicoFactory, calendarConfig, modalService, dataStorage, $filter, ngToast, $location) {
      var vm = this;

      if (dataStorage.getUser() == null) {
         $location.path('/login');
         ngToast.danger({content: 'Necessário realizar o login antes de utilizar esta funcionalidade'});
      }

      if (!dataStorage.checkPermission('Servico')) {
         $location.path('/erro');
         ngToast.danger({content: 'Você não tem permissão para acessar esta funcionalidade'});
      }

      vm.form = {};

      vm.get = get;
      vm.add = add;
      vm.alt = alt;
      vm.del = del;

      get();

      function get() {
         ServicoFactory.get()
         .then(function (response) {
            vm.servicos = response.data.result;
         });
      }

      function add() {
         ServicoFactory.add(vm.form)
         .then(function (response) {
            if (response.data.success === true) {
               ngToast.success({content: 'Registro adicionado com sucesso'});
               vm.form.nome = null;
               get();
            } else {
               ngToast.danger({content: 'Falha ao adicionar o registro'});
            }
         });
      }

      function alt(data, id) {
         ServicoFactory.alt(data, id)
         .then(function (response) {
            if (response.data.success === true) {
               get();
               ngToast.success({content: 'Registro alterado com sucesso'});
            } else {
               ngToast.danger({content: 'Falha ao alterar o registro'});
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
            ServicoFactory.del(entry.id)
            .then(function (response) {
               if (response.data.success === true) {
                  get();
                  ngToast.success({content: 'Registro excluído com sucesso'});
               } else {
                  ngToast.danger({content: 'Falha ao excluir o registro'});
               }
            });
         });
      }
   }

   ServicoFactory.$inject = ['$http', 'Fluffy'];

   function ServicoFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var ServicoFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return ServicoFactory;

      function get() {
         return $http.get(
            _url + '/servico'
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

      function add(data) {
         return $http({
            url: _url + '/servico',
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
            url: _url + '/servico',
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
            url: _url + '/servico',
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
