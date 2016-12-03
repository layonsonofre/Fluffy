(function () {
   'use strict';

   angular
   .module('Transacao', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/caixa/lancamento', {
         templateUrl: '../static/partials/caixa/lancamento.html',
         controller: 'TransacaoController',
         controllerAs: 'vm'
      })
      .when('/caixa/lista', {
         templateUrl: '../static/partials/caixa/lista.html',
         controller: 'TransacaoController',
         controllerAs: 'vm'
      });
   }])
   .controller('TransacaoController', TransacaoController)
   .factory('TransacaoFactory', TransacaoFactory);

   TransacaoController.$inject = ['TransacaoFactory', 'modalService', 'ngToast', '$filter', '$location', 'dataStorage'];

   function TransacaoController(TransacaoFactory, modalService, ngToast, $filter, $location, dataStorage) {
      var vm = this;

      if (dataStorage.getUser() == null) {
         $location.path('/login');
         ngToast.danger({content: 'Necessário realizar o login antes de utilizar esta funcionalidade'});
      }

      if (!dataStorage.checkPermission('Venda')) {
         $location.path('/erro');
         ngToast.danger({content: 'Você não tem permissão para acessar esta funcionalidade'});
      }

      vm.form = {};

      vm.getHistorico = getHistorico;
      vm.alt = alt;
      vm.del = del;
      vm.add = add;

      function getHistorico() {
         var inicio = vm.form.data_inicio ? new Date(vm.form.data_inicio).toISOString().substring(0, 19).replace('T', ' ') : null;
         var fim = vm.form.data_fim ? new Date(vm.form.data_fim).toISOString().substring(0, 19).replace('T', ' ') : null;
         var tipo = vm.form.tipo;
         TransacaoFactory.getHistorico({
            data_inicio: inicio,
            data_fim: fim,
            tipo: tipo
         })
         .then(function (response) {
            if (response.data.success === true) {
               ngToast.success({ content: 'Mostrando registros encontrados' });
               console.log('transacao', response);
               vm.total = response.data.result.caixa;
               vm.historico = response.data.result.historico;
               vm.soma_credito = response.data.result.soma_credito;
               vm.soma_debito = response.data.result.soma_debito;
               vm.servicos_executados = response.data.result.servicos_executados;
               vm.servicos_pagos = response.data.result.servicos_pagos;
               vm.servicos_totais = response.data.result.servicos_totais;
               vm.vendas_pagas = response.data.result.vendas_pagas;
               vm.vendas_totais = response.data.result.vendas_totais;
               angular.forEach(vm.historico, function (value, key) {
                  value.data_hora = $filter('date')(new Date(value.data_hora), 'dd/MM/yyyy');
               });
            } else {
               ngToast.danger({ content: 'Falha na busca pelos registros' });
            }
         });
      }

      function add() {
         TransacaoFactory.add(vm.form)
         .then(function (response) {
            console.log("response", response);
            if (response.data.success != true) {
               ngToast.danger({
                  content: '<b>Falha ao adicionar o registro</b>: ' + response.data.message
               });
            } else {
               ngToast.success({
                  content: 'Registro adicionado com sucesso'
               });
            }
         });
      }

      function alt(data) {
         TransacaoFactory.alt(data)
         .then(function (response) {
            getHistorico();
            if (response.data.success != true) {
               ngToast.danger({
                  content: '<b>Falha ao alterar o registro</b>: ' + response.data.message
               });
            } else {
               ngToast.success({
                  content: 'Registro alterado com sucesso'
               });
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
            TransacaoFactory.del(entry.id)
            .then(function (response) {
               if (response.data.success != true) {
                  ngToast.danger({
                     content: '<b>Falha ao excluir o registro</b>: ' + response.data.message
                  });
               } else {
                  ngToast.success({
                     content: 'Registro excluído com sucesso'
                  });
                  getHistorico();
               }
            });
         });
      }

      vm.openDataInicio = function () {
         vm.popupDataInicio = true;
      }
      vm.openDataFim = function () {
         vm.popupDataFim = true;
      }

      vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
      vm.format = vm.formats[0];
      vm.altInputFormats = ['d!/M!/yyyy'];

      vm.popupDataInicio = false;
      vm.popupDataFim = false;
      vm.setDate = setDate;

      function setDate(value, year, month, day) {
         value = new Date(year, month, day);
      }
   }

   TransacaoFactory.$inject = ['$http', 'Fluffy'];

   function TransacaoFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var TransacaoFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del,
         getHistorico: getHistorico
      };
      return TransacaoFactory;

      function get(data) {
         data = data || null;
         return $http({
            url: _url + '/transacao',
            params: data,
            method: 'GET'
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

      function getHistorico(data) {
         data = data || null;
         return $http({
            url: _url + '/getHistorico',
            params: data,
            method: 'GET'
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
            method: 'POST',
            url: _url + '/transacao',
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
            url: _url + '/transacao',
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
            url: _url + '/transacao',
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
