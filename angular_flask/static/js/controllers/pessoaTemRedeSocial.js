(function() {
  'use strict';

  angular
    .module('PessoaTemRedeSocial', [])
    .factory('PessoaTemRedeSocialFactory', PessoaTemRedeSocialFactory);

  PessoaTemRedeSocialFactory.$inject = ['$http', 'Fluffy'];

  function PessoaTemRedeSocialFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var PessoaTemRedeSocialFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return PessoaTemRedeSocialFactory;

    function get(data) {
      data = data || null;
      return $http({
        url: _url + '/pessoaTemRedeSocial',
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
          url: _url + '/pessoaTemRedeSocial',
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
          url: _url + '/pessoaTemRedeSocial',
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
          url: _url + '/pessoaTemRedeSocial',
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
