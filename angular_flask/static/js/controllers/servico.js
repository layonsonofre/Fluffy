(function() {
  'use strict';

  angular
    .module('Servico', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/servico/cadastro', {
          templateUrl: '../static/partials/servico/cadastro.html',
          controller: 'ServicoController',
          controllerAs: 'vm'
        });
    }])
    .controller('ServicoController', ServicoController)
    .factory('ServicoFactory', ServicoFactory);

  ServicoController.$inject = ['ServicoFactory', 'calendarConfig', 'modalService', '$filter'];

  function ServicoController(ServicoFactory, calendarConfig, modalService, $filter) {
    var vm = this;

    vm.form = {};

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    get();

    function get() {
      ServicoFactory.get()
        .then(function(response) {
          vm.servicos = response.data.result;
        }, function(response) {
          console.error(response);
        });
    }

    function add() {
      ServicoFactory.add(vm.form)
        .then(function(response) {
          vm.form.nome = null;
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data, id) {
      ServicoFactory.alt(data, id)
        .then(function(response) {
          get();
        }, function(response) {
          console.error(response)
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
          ServicoFactory.del(entry.id)
            .then(function(response) {
              get();
            }, function(response) {
              vm.status = response;
            });
        });
    }
  }

  ServicoFactory.$inject = ['$http', 'Fluffy'];

  function ServicoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var ServicoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return ServicoFactory;

    function get() {
      return $http.get(
          _url + '/servico'
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
          url: _url + '/servico',
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
          url: _url + '/servico',
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
          url: _url + '/servico',
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
