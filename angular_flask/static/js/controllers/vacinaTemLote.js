(function () {
   'use strict';

   angular
   .module('VacinaTemLote', [])
   .factory('VacinaTemLoteFactory', VacinaTemLoteFactory);

   VacinaTemLoteFactory.$inject = ['$http', 'Fluffy'];

   function VacinaTemLoteFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var VacinaTemLoteFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return VacinaTemLoteFactory;

      function get(data) {
         data = data || null;
         return $http({
            url: _url + '/vacinaTemLote',
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
            url: _url + '/vacinaTemLote',
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
            url: _url + '/vacinaTemLote',
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
            url: _url + '/vacinaTemLote',
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


      function getLotesVacina(data) {
         data = data || null;
         return $http({
            url: _url + '/vacinaTemLote',
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
   }

})()
