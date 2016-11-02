(function() {
  'use strict';

  angular
    .module('Funcao', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/funcao', {
          templateUrl: '../static/partials/avancado/funcao.html',
          controller: 'FuncaoController',
          controllerAs: 'vm'
        })
    }])
    .controller('FuncaoController', FuncaoController)
    .factory('FuncaoFactory', FuncaoFactory);

  FuncaoController.$inject = ['FuncaoFactory', 'modalService'];

  function FuncaoController(FuncaoFactory, modalService) {
    var vm = this;
    vm.form = null;

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    get();

    function get() {
      FuncaoFactory.get()
        .then(function(response) {
          vm.funcoes = response;
        }, function(response) {
          console.log('Failed to load funcao' + response);
        });
    }

    function add() {
      FuncaoFactory.add(vm.form)
        .then(function(response) {
          vm.form = null;
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data) {
      FuncaoFactory.alt(data)
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
          FuncaoFactory.del(entry.id)
            .then(function(response) {
              get();
            }, function(response) {
              vm.status = response.message
            });
        });
    }
  }

  FuncaoFactory.$inject = ['$http', 'Fluffy'];

  function FuncaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var FuncaoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return FuncaoFactory;

    function get() {
      return $http.get(_url + '/funcao')
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed funcoes: ' + error.data);
      }
    }

    function add(data) {
      return $http({
          url: _url + '/funcao',
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
          url: _url + '/funcao',
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
          url: _url + '/funcao',
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
