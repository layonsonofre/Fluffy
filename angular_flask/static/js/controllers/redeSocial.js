(function() {
  'use strict';

  angular
    .module('RedeSocial', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/redesSociais', {
          templateUrl: '../static/partials/avancado/redeSocial.html',
          controller: 'RedeSocialController',
          controllerAs: 'vm'
        })
    }])
    .controller('RedeSocialController', RedeSocialController)
    .factory('RedeSocialFactory', RedeSocialFactory);

  RedeSocialController.$inject = ['RedeSocialFactory', 'modalService'];

  function RedeSocialController(RedeSocialFactory, modalService) {
    var vm = this;
    vm.form = null;

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    get();

    function get() {
      RedeSocialFactory.get()
        .then(function(response) {
          vm.redesSociais = response;
        }, function(response) {
          vm.status = response.message
        });
    }

    function add() {
      RedeSocialFactory.add(vm.form)
        .then(function(response) {
          vm.form = null;
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data) {
      RedeSocialFactory.alt(data)
        .then(function(response) {
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function del(entry) {
      var modalOptions = {
        closeButtonText: 'Cancelar',
        actionButtonText: 'Excluir',
        actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
        .then(function(result) {
          RedeSocialFactory.del(entry.id)
            .then(function(response) {
              get();
            }, function(response) {
              vm.status = response.message
            });
        });
    }
  }

  RedeSocialFactory.$inject = ['$http', 'Fluffy'];

  function RedeSocialFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var RedeSocialFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return RedeSocialFactory;

    function get() {
      return $http.get(
          _url + '/redeSocial'
        )
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(response) {
        console.error('Failed: ' + JSON.stringify(response));
      }
    }

    function add(data) {
      return $http({
          url: _url + '/redeSocial',
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
      return $http({
          url: _url + '/redeSocial',
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
          url: _url + '/redeSocial',
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
