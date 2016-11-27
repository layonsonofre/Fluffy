(function () {
  'use strict';

  angular
    .module('Raca', [])
    .factory('RacaFactory', RacaFactory);

  RacaFactory.$inject = ['$http', 'Fluffy'];

  function RacaFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var RacaFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return RacaFactory;

    function get(data) {
      data = data || null;
      return $http({ url: _url + '/raca', method: 'GET', params: data })
        .then(success)
        .catch(failed);

      function success(response) {
        return response;
      }

      function failed(error) {
        return error;
      }
    }

    function add(data) {
      return $http({
          method: 'POST',
          url: _url + '/raca',
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
          url: _url + '/raca',
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
          url: _url + '/raca',
          data: {
            id: id
          }
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
