(function() {
   'use strict';

   angular
      .module('Servico', [])
      .config(['$routeProvider', function($routeProvider) {
         $routeProvider
            .when('/servico/cadastro', {
               templateUrl: '../static/partials/servico/cadastro.html',
               controller: 'ServicoController',
               controllerAs: 'Servico'
            })
            .when('/servico/agendar', {
               templateUrl: '../static/partials/servico/agendar.html',
               controller: 'ServicoController',
               controllerAs: 'Servico'
            })
      }])
      .controller('ServicoController', ServicoController)
      .factory('ServicoFactory', ServicoFactory);

   ServicoController.$inject = ['$scope', 'ngDragDrop', 'ServicoFactory'];

   function ServicoController($scope, ngDragDrop, ServicoFactory) {
      var vm = this;

      vm.add = add;
      vm.alt = alt;
      vm.del = del;

      ServicoFactory.getAgendados()
         .then(function(response) {
            vm.agendadosHoje = response.data.result;
            console.log(response.data.result);
         }, function(response) {
            console.error(response);
         });

      ServicoFactory.get()
         .then(function(response) {
            alert(response);
            vm.servicos = response.data.result;
            console.log(response.data.result);
         }, function(response) {
            console.error(response);
         });

      function add(data) {
         ServicoFactory.add(data).then(function(response) {
            console.log(response);
         }, function(response) {
            console.error(response)
         });
      }

      function alt(data, id) {
         ServicoFactory.alt(data, id)
            .then(function(response) {
               console.log(response.data.result);
            }, function(response) {
               console.error(response)
            });
      }

      function del(id) {
         console.log(JSON.stringify(id));
         ServicoFactory.del(id)
            .then(function(response) {
               console.log(response);
            }, function(response) {
               console.error(response)
            });
      }

      vm.agendamentos = [];
      //
      // $scope.animais = [{
      //    'nome': 'Fluffy',
      //    'sexo': 'm',
      //    'data': '15/08/1992',
      //    'raca': 'Pastor Alemão'
      // }, {
      //    'nome': 'Bumma',
      //    'sexo': 'f',
      //    'data': '28/11/2013',
      //    'raca': 'Beagle'
      // }];
      // $scope.servicosAgendados = [];
      // $scope.removeServicosAgendados = function(index) {
      //    $scope.servicosAgendados.splice(index, 1);
      // }
      // $scope.animalAgendado = {
      //    'nome': ''
      // };
      // $scope.removeAnimalAgendado = function() {
      //    $scope.animalAgendado = {
      //       'nome': ''
      //    };
      // }
   }

   ServicoFactory.$inject = ['$http', 'Fluffy'];

   function ServicoFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var ServicoFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del,
         getAgendados: getAgendados
      };
      return ServicoFactory;

      function get() {
         return $http.get(
               _url + '/servico'
            )
            .then(success)
            .catch(failed);

         function success(response) {
            console.log(response);
            return response;
         }

         function failed(response) {
            console.error('Failed: ' + JSON.stringify(response));
         }
      }

      function add(data) {
         console.log('SAVING: ' + JSON.stringify(data));
         return $http.post(
               _url + '/servico',
               data
            )
            .then(success)
            .catch(failed);

         function success(response) {
            return response;
         }

         function failed(response) {
            console.error('Failed: ' + JSON.stringify(response));
         }
      }

      function alt(data, id) {
         console.log('UPDATING: ' + JSON.stringify({
            id: id,
            data: data
         }));
         return $http({
               url: _url + '/servico',
               data: {
                  id: id
               },
               method: 'PUT'
            })
            .then(success)
            .catch(failed);

         function success(response) {
            return response;
         }

         function failed(response) {
            console.error('Failed: ' + JSON.stringify(response));
         }
      }

      function del(id) {
         return $http.delete(
               _url + '/servico',
               id
            )
            .then(success)
            .catch(failed);

         function success(response) {
            return response;
         }

         function failed(response) {
            console.error('Failed: ' + JSON.stringify(response));
         }
      }

      function getAgendados() {
         alert('oi');
         return $http.get(
               _url + '/servicoAgendado'
            )
            .then(success)
            .catch(failed);

         function success(response) {
            return response;
         }

         function failed(response) {
            console.error('Failed: ' + JSON.stringify(response));
         }
      }
   }

})()
