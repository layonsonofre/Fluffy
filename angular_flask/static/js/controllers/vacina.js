(function() {
  'use strict';

  angular
    .module('Vacina', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/estoque/vacina', {
          templateUrl: '../static/partials/estoque/vacina.html',
          controller: 'VacinaController',
          controllerAs: 'vm'
        })
    }])
    .controller('VacinaController', VacinaController)
    .factory('VacinaFactory', VacinaFactory);

  VacinaController.$inject = ['VacinaFactory', 'LoteFactory', 'modalService'];

  function VacinaController(VacinaFactory, LoteFactory, modalService) {
    var vm = this;
    vm.form = {};

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    vm.getLote = getLote;
    vm.addLote = addLote;
    vm.altLote = altLote;
    vm.delLote = delLote;

    vm.incluirLote = incluirLote;

    get();

    function get() {
      VacinaFactory.get()
        .then(function(response) {
          vm.vacinas = response.data.result;
        }, function(response) {
          vm.status = response.message
        });
    }

    function add() {
      VacinaFactory.add(vm.form)
        .then(function(response) {
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data) {
      VacinaFactory.alt(data)
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
          VacinaFactory.del(entry.id)
            .then(function(response) {
              get();
            }, function(response) {
              vm.status = response.message
            });
        });
    }

    function incluirLote() {
      if (!vm.form.lotes) {
        vm.form.lotes = [];
      }
      vm.form.lotes.push({
        id: null
      });
    }

    function addLote() {
      LoteFactory.add(vm.form)
        .then(function(response) {
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function altLote(data) {
      LoteFactory.altLote(data)
        .then(function(response) {
          getLote();
        }, function(response) {
          vm.status = response.message
        });
    }

    function delLote(item) {
      if (item.id === null) {
        vm.form.lotes = vm.form.lotes.splice(vm.form.lotes.indexOf(item), 1)
      } else {
        var modalOptions = {
          closeButtonText: 'Cancelar',
          actionButtonText: 'Excluir',
          actionButtonClass: 'btn btn-danger'
        };
        modalService.showModal({}, modalOptions)
          .then(function(result) {
            LoteFactory.del(entry.id)
              .then(function(response) {
                getLote();
              }, function(response) {
                vm.status = response.message
              });
          });
      }
    }
    
    function getLote(entry) {
      vm.form.lotes = {};
      if (entry.checked) {
        LoteFactory.getLotesVacina(entry.id)
          .then(function(response) {
            vm.form.lotes = response;
            console.log(vm.form.lotes);
          }, function(response) {
            vm.status = 'Failed to load: ' + error.message;
          });
      }
    }

    function updateSelection(position, entities) {
      angular.forEach(entities, function(subscription, index) {
        if (position != index) {
          subscription.checked = false;
        }
      });
    }
  }

  VacinaFactory.$inject = ['$http', 'Fluffy'];

  function VacinaFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var VacinaFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return VacinaFactory;

    function get() {
      return $http.get(
          _url + '/vacina'
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
          url: _url + '/vacina',
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
          url: _url + '/vacina',
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
          url: _url + '/vacina',
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
