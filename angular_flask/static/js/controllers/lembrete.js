(function () {
   'use strict';

   angular
   .module('Lembrete', [])
   .controller('LembreteController', LembreteController)
   .factory('LembreteFactory', LembreteFactory);

   LembreteController.$inject = ['LembreteFactory', 'modalService', 'ngToast', '$filter', 'dataStorage', '$location'];

   function LembreteController(LembreteFactory, modalService, ngToast, $filter, dataStorage, $location) {
      var vm = this;

      if (dataStorage.getUser() == null) {
         $location.path('/login');
         ngToast.danger({content: 'Necessário realizar o login antes de utilizar esta funcionalidade'});
      }

      if (!dataStorage.checkPermission('Cadastro')) {
         $location.path('/erro');
         ngToast.danger({content: 'Você não tem permissão para acessar esta funcionalidade'});
      }

      vm.form = {};
      vm.form.visualizado = false;
      vm.form.pessoa_id = 3;

      vm.get = get;
      vm.add = add;
      vm.alt = alt;
      vm.del = del;

      get();

      function get() {
         LembreteFactory.get()
         .then(function (response) {
            vm.lembretes = response.data.result;
            angular.forEach(vm.lembretes, function (value, key) {
               value.data_hora = $filter('date')(new Date(value.data_hora), 'dd/MM/yyyy');
            });
         });
      }

      function add() {
         // vm.form.data_hora = new Date(vm.form.data_hora).toISOString().substring(0, 19).replace('T', ' ');
         vm.form.data_hora = $filter('date')(new Date(vm.form.data_hora), 'yyyy-MM-dd HH:mm:ss');
         // console.log("data_hora", vm.form.data_hora);
         LembreteFactory.add(vm.form)
         .then(function (response) {
            if (response.data.success != true) {
               ngToast.danger({ content: '<b>Falha ao adicionar o registro</b>: ' + response.data.message });
            } else {
               ngToast.success({ content: 'Registro adicionado com sucesso' });
            }
         });
      }

      function alt(data) {
         data.data_hora = $filter('date')(new Date(data.data_hora), 'yyyy-MM-dd HH:mm:ss');
         LembreteFactory.alt(data)
         .then(function (response) {
            get();
            if (response.data.success != true) {
               ngToast.danger({ content: '<b>Falha ao alterar o registro</b>: ' + response.data.message });
            } else {
               ngToast.success({ content: 'Registro alterado com sucesso' });
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
            LembreteFactory.del(entry.id)
            .then(function (response) {
               if (response.data.success != true) {
                  ngToast.danger({ content: '<b>Falha ao excluir o registro</b>: ' + response.data.message });
               } else {
                  ngToast.success({ content: 'Registro excluído com sucesso' });
               }
               get();
            });
         });
      }

      vm.openData = function () {
         vm.popupData = true;
      }

      vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
      vm.format = vm.formats[0];
      vm.altInputFormats = ['d!/M!/yyyy'];

      vm.popupData = false;
      vm.setDate = setDate;

      function setDate(year, month, day) {
         vm.form.data_hora = new Date(year, month, day);
      }
   }

   LembreteFactory.$inject = ['$http', 'Fluffy'];

   function LembreteFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var LembreteFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return LembreteFactory;

      function get() {
         return $http.get(
            _url + '/lembrete'
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
            method: 'POST',
            url: _url + '/lembrete',
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
            url: _url + '/lembrete',
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
            url: _url + '/lembrete',
            data: {
               id: id
            }
         })
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
   }
})()
