(function() {
  'use strict';

  angular
    .module('Lote', [])
    .factory('LoteFactory', LoteFactory);

  LoteFactory.$inject = ['$http', 'Fluffy'];

  function LoteFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var LoteFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del,
      getLotesVacina: getLotesVacina
    };
    return LoteFactory;

    function get() {
      data = data || null;
      return $http({
          url: _url + '/lote',
          params: data,
          method: 'GET'
        })
        .then(success)
        .catch(failed);

      function success(response) {
        console.log(response);
        return response.data.result;
      }

      function failed(response) {
        console.error('Failed: ' + JSON.stringify(response));
      }
    }

    function add(data) {
      return $http({
          url: _url + '/lote',
          data: data,
          method: 'POST'
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
      return $http({
          url: _url + '/lote',
          data: data,
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
      return $http({
          url: _url + '/lote',
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
        console.error('Failed: ' + JSON.stringify(response));
      }
    }


    function getLotesVacina(data) {
      data = data || null;
      console.log(data);
      return $http({
          url: _url + '/vacinaTemLote',
          params: data,
          method: 'GET'
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(response) {
        console.error('Failed: ' + JSON.stringify(response));
      }
    }
  }

})()
