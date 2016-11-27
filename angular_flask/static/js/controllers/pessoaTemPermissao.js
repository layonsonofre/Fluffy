(function () {
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
        return response;
      }

      function failed(error) {
        return error;
      }
    }

    function add(data) {
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
        return response;
      }
    }

    function alt(data) {
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
        return response;
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
        return response;
      }
    }
  }
})()
