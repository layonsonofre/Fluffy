(function () {
   'use strict';

   angular
   .module('Raca', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/racas', {
         templateUrl: '../static/partials/avancado/raca.html',
         controller: 'RacaController',
         controllerAs: 'vm'
      })
   }])
   .controller('RacaController', RacaController)
   .factory('RacaFactory', RacaFactory);



   RacaController.$inject = ['RacaFactory', 'modalService', '$location', 'dataStorage', 'ngToast', 'EspecieFactory'];

   function RacaController(RacaFactory, modalService, $location, dataStorage, ngToast, EspecieFactory) {
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
         RacaFactory.get()
         .then(function (response) {
            vm.racas = response.data.result;
         });

         EspecieFactory.get()
         .then(function(response) {
            vm.especies = response.data.result;
         });
      }

      function add() {
         RacaFactory.add(vm.form)
         .then(function (response) {
            if (response.data.success === true) {
               get();
               vm.form = null;
               ngToast.success({ content: 'Registro inserido com sucesso'});
            } else {
               ngToast.danger({ content: 'Falha ao inserir o registro: ' + response.data.message });
            }
         });
      }

      function alt(data) {
         RacaFactory.alt(data)
         .then(function (response) {
            if (response.data.success === true) {
               get();
               ngToast.success({ content: 'Registro alterado com sucesso'});
            } else {
               ngToast.danger({ content: 'Falha ao alterar o registro' + response.data.message });
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
            RacaFactory.del(entry.id)
            .then(function (response) {
               if (response.data.success === true) {
                  get();
                  ngToast.success({ content: 'Registro exlcuído com sucesso'});
               } else {
                  ngToast.danger({ content: 'Falha ao excluir o registro: ' + response.data.message });
               }
            });
         });
      }
   }

   RacaFactory.$inject = ['$http', 'Fluffy'];

   function RacaFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var RacaFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return RacaFactory;

      function get(data) {
         data = data || null;
         return $http({ url: _url + '/raca', method: 'GET', params: data })
         .then(success)
         .catch(failed);

         function success(response) {
            return response;
         }

         function failed(error) {
            return error;
         }
      }

      function add(data) {
         return $http({
            method: 'POST',
            url: _url + '/raca',
            data: data
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
            method: 'PUT',
            url: _url + '/raca',
            data: data
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
            method: 'DELETE',
            url: _url + '/raca',
            data: {
               id: id
            }
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
