(function() {
  'use strict';

  angular
    .module('PessoaTemPermissao', [])
    .factory('PessoaTemPermissaoFactory', PessoaTemPermissaoFactory);

  PessoaTemPermissaoFactory.$inject = ['$http', 'Fluffy'];

  function PessoaTemPermissaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var PessoaTemPermissaoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return PessoaTemPermissaoFactory;

    function get(data) {
      data = data || null;
      return $http({
        url: _url + '/pessoaTemPermissao',
        method: 'GET',
        params: data
      })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed: ' + error.data);
      }
    }

    function add(data) {
      console.log('add', JSON.stringify(data));
      return $http({
          url: _url + '/pessoaTemPermissao',
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
          url: _url + '/pessoaTemPermissao',
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
          url: _url + '/pessoaTemPermissao',
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
