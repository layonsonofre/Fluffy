(function () {
   'use strict';

   angular
   .module('Telefone', [])
   .factory('TelefoneFactory', TelefoneFactory);

   TelefoneFactory.$inject = ['$http', 'Fluffy'];

   function TelefoneFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var TelefoneFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return TelefoneFactory;

      function get(data) {
         data = data || null;
         return $http({
            url: _url + '/telefone',
            method: 'GET',
            params: data
         })
         .then(success)
         .catch(failed);

         function success(response) {
            console.log(response);
            return response;
         }

         function failed(error) {
            return error;
         }
      }

      function add(data) {
         return $http({
            url: _url + '/telefone',
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
            url: _url + '/telefone',
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
            url: _url + '/telefone',
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
