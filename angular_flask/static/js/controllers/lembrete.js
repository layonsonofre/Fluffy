(function() {
   'use strict';

   angular
      .module('Lembrete', [])
      .controller('LembreteController', LembreteController)
      .factory('LembreteFactory', LembreteFactory);

   LembreteController.$inject = ['$scope', '$http', 'LembreteFactory'];

   function LembreteController($scope, $http, LembreteFactory) {
      var vm = this;

      vm.add = add;
      vm.alt = alt;
      vm.del = del;
      vm.cancel = cancel;

      LembreteFactory.get()
         .then(function(response) {
            vm.lembretes = response.data.result;
         }, function(response) {
            console.error(response);
         });

      function add() {
         var data = {
            descricao: vm.descricao,
            data_hora: vm.data_hora,
            executado: vm.executado
         }
         LembreteFactory.add(data)
            .then(function(response) {
               console.log(response);
            }, function(response) {
               console.error(response)
            });
      }

      function alt(data, id, pessoa) {
         LembreteFactory.alt(data, id, pessoa).then(function(response) {
            console.log(response.data.result);
         }, function(response) {
            console.error(response)
         });
      }

      function del(id) {
         console.log(JSON.stringify(id));
         LembreteFactory.del(id).then(function(response) {
            console.log(response);
         }, function(response) {
            console.error(response)
         });
      }

      function cancel() {
         console.log('Discarding changes...');
         vm.descricao = null;
         vm.data_hora = null;
         vm.executado = null;
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
            console.error('Failed: ' + JSON.stringify(response));
         }
      }

      function add(data) {
         console.log('SAVING: ' + JSON.stringify(data));
         return $http.post(
               _url + '/lembrete',
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

      function alt(data, id, pessoa) {
         console.log('UPDATING: ' + JSON.stringify({
            id: pessoa.id
         }));
         return $http({
               method: 'PUT',
               url: _url + '/lembrete',
               data: {
                  id: id,
                  descricao: data.descricao,
                  pessoa_id: pessoa.id
               }
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
               _url + '/lembrete',
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
   }
})()
