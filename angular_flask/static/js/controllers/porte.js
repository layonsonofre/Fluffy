(function() {
  'use strict';

  angular
    .module('Porte', [])
    .factory('PorteFactory', PorteFactory);

  PorteFactory.$inject = ['$http', 'Fluffy'];

  function PorteFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var PorteFactory = {
      get: get,
      add: add
    };
    return PorteFactory;

    function get() {
      return $http.get(_url + '/porte')
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getPorte: ' + error.data);
      }
    }

    function add(data) {
      console.log('SAVING: ' + JSON.stringify(data));
      return $http({
          method: 'POST',
          url: _url + '/porte',
          data: data
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
  }
})()
