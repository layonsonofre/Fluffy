(function () {
  'use strict';

  angular
    .module('Anamnese', [])
    .factory('AnamneseFactory', AnamneseFactory);

  AnamneseFactory.$inject = ['$http', 'Fluffy'];

  function AnamneseFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var AnamneseFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return AnamneseFactory;

    function get() {
      return $http.get(
          _url + '/anamnese'
        )
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

    function add(data) {
      return $http({
          url: _url + '/anamnese',
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
          url: _url + '/anamnese',
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
          url: _url + '/anamnese',
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
