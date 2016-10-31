(function() {
  'use strict';

  angular
    .module('GrupoItem', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/estoque/grupoItem', {
          templateUrl: '../static/partials/estoque/grupoItem.html',
          controller: 'GrupoItemController',
          controllerAs: 'vm'
        })
    }])
    .controller('GrupoItemController', GrupoItemController)
    .factory('GrupoItemFactory', GrupoItemFactory);

  GrupoItemController.$inject = ['GrupoItemFactory', 'modalService'];

  function GrupoItemController(GrupoItemFactory, modalService) {
    var vm = this;
    vm.form = null;

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    get();

    function get() {
      GrupoItemFactory.get()
        .then(function(response) {
          vm.grupos = response.data.result;
        }, function(response) {
          vm.status = response.message
        });
    }

    function add() {
      GrupoItemFactory.add(vm.form)
        .then(function(response) {
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data) {
      GrupoItemFactory.alt(data)
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
          GrupoItemFactory.del(entry.id)
            .then(function(response) {
              get();
            }, function(response) {
              vm.status = response.message
            });
        });
    }
  }

  GrupoItemFactory.$inject = ['$http', 'Fluffy'];

  function GrupoItemFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var GrupoItemFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return GrupoItemFactory;

    function get() {
      return $http.get(
          _url + '/grupoDeItem'
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
          url: _url + '/grupoDeItem',
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
          url: _url + '/grupoDeItem',
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
          url: _url + '/grupoDeItem',
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
