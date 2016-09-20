(function() {
   'use strict';

   angular
      .module('Lembrete', [])
      .controller('LembreteController', LembreteController)
      .factory('LembreteFactory', LembreteFactory);

   LembreteController.$inject = ['$scope', '$http', 'LembreteFactory'];

   function LembreteController($scope, $http, LembreteFactory) {
      var vm = this;

      vm.form = {};
      vm.form.visualizado = false;
      vm.form.pessoa_id = 3;

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
         LembreteFactory.add(vm.form)
            .then(function(response) {
               console.log(response);
            }, function(response) {
               console.error(response)
            });
      }

      function alt(data) {
         LembreteFactory.alt(data)
            .then(function(response) {
               console.log(response);
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
         vm.visualizado = null;
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
         return $http({
               method: 'POST',
               url: _url + '/lembrete',
               data: {
                  descricao: data.descricao,
                  data_hora: data.data_hora,
                  visualizado: data.visualizado
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

      function alt(data) {
         console.log('UPDATING: ' + JSON.stringify(data));
         console.log(JSON.stringify({visualizado: data.visualizado === false ? 0 : 1}))
         return $http({
               method: 'PUT',
               url: _url + '/lembrete',
               data: {
                  id: data.id,
                  descricao: data.descricao,
                  pessoa_id: data.pessoa.id,
                  visualizado: data.visualizado === false ? 0 : 1,
                  data_hora: data.data_hora
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
         console.log(JSON.stringify(id));
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
            console.error('Failed: ' + JSON.stringify(response));
         }
      }
   }
})()
