(function() {
  'use strict';

  angular
    .module('Telefone', [])
    .factory('TelefoneFactory', TelefoneFactory);

  TelefoneFactory.$inject = ['$http', 'Fluffy'];

  function TelefoneFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var TelefoneFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return TelefoneFactory;

    function get(data) {
      data = data || null;
      return $http({
        url: _url + '/telefone',
        method: 'GET',
        params: data
      })
        .then(success)
        .catch(failed);

      function success(response) {
        console.log(response);
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed: ' + error.data);
      }
    }

    function add(data) {
      return $http({
          url: _url + '/telefone',
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
          url: _url + '/telefone',
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
          url: _url + '/telefone',
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
  }
})()
