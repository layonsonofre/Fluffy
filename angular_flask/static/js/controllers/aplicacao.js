(function () {
  'use strict';

  angular
    .module('Aplicacao', [])
    .factory('AplicacaoFactory', AplicacaoFactory);

  AplicacaoFactory.$inject = ['$http', 'Fluffy'];

  function AplicacaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var AplicacaoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return AplicacaoFactory;

    function get() {
      return $http.get(
          _url + '/aplicacao'
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
          url: _url + '/aplicacao',
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
          url: _url + '/aplicacao',
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
          url: _url + '/aplicacao',
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
