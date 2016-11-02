(function() {
  'use strict';

  angular
    .module('Permissao', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/permissao', {
          templateUrl: '../static/partials/avancado/permissao.html',
          controller: 'PermissaoController',
          controllerAs: 'vm'
        })
    }])
    .controller('PermissaoController', PermissaoController)
    .factory('PermissaoFactory', PermissaoFactory);

  PermissaoController.$inject = ['PermissaoFactory', 'modalService'];

  function PermissaoController(PermissaoFactory, modalService) {
    var vm = this;
    vm.form = null;

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    get();

    function get() {
      PermissaoFactory.get()
        .then(function(response) {
          vm.permissoes = response.data.result;
        }, function(response) {
          vm.status = response.message
        });
    }

    function add() {
      PermissaoFactory.add(vm.form)
        .then(function(response) {
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data) {
      PermissaoFactory.alt(data)
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
          PermissaoFactory.del(entry.id)
            .then(function(response) {
              get();
            }, function(response) {
              vm.status = response.message
            });
        });
    }
  }

  PermissaoFactory.$inject = ['$http', 'Fluffy'];

  function PermissaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var PermissaoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return PermissaoFactory;

    function get() {
      return $http.get(
          _url + '/permissao'
        )
        .then(success)
        .catch(failed);

      function success(response) {
        console.log(response);
        return response;
      }

      function failed(response) {
        console.error('Failed: ' + JSON.stringify(response));
      }
    }

    function add(data) {
      return $http({
          url: _url + '/permissao',
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
          url: _url + '/permissao',
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
          url: _url + '/permissao',
          data: id,
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
