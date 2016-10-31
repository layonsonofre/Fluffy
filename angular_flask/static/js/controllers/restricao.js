(function() {
  'use strict';

  angular
    .module('Restricao', [])
    .factory('RestricaoFactory', RestricaoFactory);

  RestricaoFactory.$inject = ['$http', 'Fluffy'];

  function RestricaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var RestricaoFactory = {
      get: get,
      add: add
    };
    return RestricaoFactory;

    function get() {
      return $http.get(_url + '/restricao')
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getRestricao: ' + error.data);
      }
    }

    function add(data) {
      console.log('SAVING: ' + JSON.stringify(data));
      return $http({
          method: 'POST',
          url: _url + '/restricao',
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
