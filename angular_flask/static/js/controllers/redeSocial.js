(function () {
   'use strict';

   angular
   .module('RedeSocial', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/redesSociais', {
         templateUrl: '../static/partials/avancado/redeSocial.html',
         controller: 'RedeSocialController',
         controllerAs: 'vm'
      })
   }])
   .controller('RedeSocialController', RedeSocialController)
   .factory('RedeSocialFactory', RedeSocialFactory);

   RedeSocialController.$inject = ['RedeSocialFactory', 'modalService', '$location', 'dataStorage', 'ngToast'];

   function RedeSocialController(RedeSocialFactory, modalService, $location, dataStorage, ngToast) {
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
         RedeSocialFactory.get()
         .then(function (response) {
            vm.redesSociais = response.data.result;
         });
      }

      function add() {
         RedeSocialFactory.add(vm.form)
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
         RedeSocialFactory.alt(data)
         .then(function (response) {
            if (response.data.success === true) {
               get();
               ngToast.success({ content: 'Registro alterado com sucesso'});
            } else {
               ngToast.danger({ content: 'Falha ao alterar o registro' });
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
            RedeSocialFactory.del(entry.id)
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

   RedeSocialFactory.$inject = ['$http', 'Fluffy'];

   function RedeSocialFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var RedeSocialFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return RedeSocialFactory;

      function get(data) {
         data = data || null;
         return $http({
            url: _url + '/redeSocial',
            method: 'GET',
            params: data
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

      function add(data) {
         return $http({
            url: _url + '/redeSocial',
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
            url: _url + '/redeSocial',
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
            url: _url + '/redeSocial',
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
