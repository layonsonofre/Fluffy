(function () {
  'use strict';

  angular
    .module('PessoaTemFuncao', [])
    .factory('PessoaTemFuncaoFactory', PessoaTemFuncaoFactory);

  PessoaTemFuncaoFactory.$inject = ['$http', 'Fluffy'];

  function PessoaTemFuncaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var PessoaTemFuncaoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return PessoaTemFuncaoFactory;

    function get(data) {
      data = data || null;
      return $http({
          url: _url + '/pessoaTemFuncao',
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
          url: _url + '/pessoaTemFuncao',
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
          url: _url + '/pessoaTemFuncao',
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
          url: _url + '/pessoaTemFuncao',
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
