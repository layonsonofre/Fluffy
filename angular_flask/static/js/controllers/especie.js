(function() {
  'use strict';

  angular
    .module('Especie', [])
    .factory('EspecieFactory', EspecieFactory);

  EspecieFactory.$inject = ['$http', 'Fluffy'];

  function EspecieFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var EspecieFactory = {
      get: get,
      add: add
    };
    return EspecieFactory;

    function get() {
      return $http.get(_url + '/especie')
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getEspecie: ' + error.data);
      }
    }

    function add(data) {
      console.log('SAVING: ' + JSON.stringify(data));
      return $http({
          method: 'POST',
          url: _url + '/especie',
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
