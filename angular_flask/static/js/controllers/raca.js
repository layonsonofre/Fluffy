(function() {
  'use strict';

  angular
    .module('Raca', [])
    .factory('RacaFactory', RacaFactory);

  RacaFactory.$inject = ['$http', 'Fluffy'];

  function RacaFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var RacaFactory = {
      get: get,
      add: add
    };
    return RacaFactory;

    function get(data) {
      data = data || null;
      return $http({url:_url + '/raca', method: 'GET', params: data})
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getRaca: ' + error.data);
      }
    }

    function add(data) {
      console.log('SAVING: ' + JSON.stringify(data));
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
        console.error('Failed: ' + JSON.stringify(response));
      }
    }
  }
})()
