(function () {
  'use strict';

  angular
    .module('AnimalTemRestricao', [])
    .factory('AnimalTemRestricaoFactory', AnimalTemRestricaoFactory);

  AnimalTemRestricaoFactory.$inject = ['$http', 'Fluffy'];

  function AnimalTemRestricaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var AnimalTemRestricaoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return AnimalTemRestricaoFactory;

    function get(data) {
      data = data || null;
      return $http({
          url: _url + '/animalTemRestricao',
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
          url: _url + '/animalTemRestricao',
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
      console.log('UPDATING: ' + JSON.stringify(data));
      return $http({
          url: _url + '/animalTemRestricao',
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
          url: _url + '/animalTemRestricao',
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
