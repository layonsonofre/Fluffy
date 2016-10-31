(function() {
  'use strict';

  angular
    .module('Estoque', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/estoque/controle', {
          templateUrl: '../static/partials/estoque/controle.html',
          controller: 'ProdutoController',
          controllerAs: 'vm'
        })
    }])
    .controller('ProdutoController', ProdutoController)
    .factory('ProdutoFactory', ProdutoFactory);

  ProdutoController.$inject = ['ProdutoFactory', 'GrupoItemFactory', 'modalService'];

  function ProdutoController(ProdutoFactory, GrupoItemFactory, modalService) {
    var vm = this;
    vm.form = null;

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;
    vm.getGrupos = getGrupos;

    get();
    getGrupos();

    function get() {
      ProdutoFactory.get()
        .then(function(response) {
          vm.produtos = response.data.result;
        }, function(response) {
          vm.status = response.message
        });
    }

    function add() {
      ProdutoFactory.add(vm.form)
        .then(function(response) {
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data) {
      ProdutoFactory.alt(data)
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
          ProdutoFactory.del(entry.id)
            .then(function(response) {
              get();
            }, function(response) {
              vm.status = response.message
            });
        });
    }

    function getGrupos() {
      GrupoItemFactory.get()
        .then(function(response) {
          vm.grupos = response.data.result;
        }, function(response) {
          vm.status = response.message
        });
    }
  }

  ProdutoFactory.$inject = ['$http', 'Fluffy'];

  function ProdutoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var ProdutoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return ProdutoFactory;

    function get() {
      return $http.get(
          _url + '/item'
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
          url: _url + '/item',
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
          url: _url + '/item',
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
          url: _url + '/item',
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
