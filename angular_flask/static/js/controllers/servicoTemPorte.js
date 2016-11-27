(function () {
  'use strict';

  angular
    .module('ServicoTemPorte', [])
    .factory('ServicoTemPorteFactory', ServicoTemPorteFactory);

  ServicoTemPorteFactory.$inject = ['$http', 'Fluffy'];

  function ServicoTemPorteFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var ServicoTemPorteFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return ServicoTemPorteFactory;

    function get(data) {
      data = data || null;
      return $http({
          url: _url + '/servicoTemPorte',
          method: 'GET',
          params: data
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        return error;
      }
    }

    function add(data) {
      return $http({
          url: _url + '/servicoTemPorte',
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
          url: _url + '/servicoTemPorte',
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
          url: _url + '/servicoTemPorte',
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
