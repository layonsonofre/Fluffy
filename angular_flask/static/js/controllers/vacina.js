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
    vm.delLote = delLote;
    vm.setLote = setLote;
    vm.cancelLote = cancelLote;

    vm.updateSelection = updateSelection;

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
      VacinaFactory.add(vm.form.vacina)
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

    function setLote(entry) {
      vm.lote = entry.lote;
      vm.alterandoLote = true;
    }


    function addLote() {
      vm.lote.vencimento = new Date(vm.lote.vencimento).toISOString().substring(0, 19).replace('T', ' ');
      if (vm.alterandoLote) {
        vm.alterandoLote = false;
        LoteFactory.alt(vm.lote)
          .then(function(response) {
            getLote(vm.vacina);
          }, function(response) {
            vm.status = response.message
          });
      } else {
        LoteFactory.add(vm.lote)
          .then(function(response) {
            getLote(vm.vacina);
          }, function(response) {
            vm.status = response.message
          });
      }
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
                getLote(vm.vacina);
              }, function(response) {
                vm.status = response.message
              });
          });
      }
    }

    function getLote(entry) {
      if (entry.checked) {
        vm.form.lotes = [];
        LoteFactory.getLotesVacina({
            vacina_id: entry.id
          })
          .then(function(response) {
            if (!angular.isArray(response)) {
              vm.form.lotes = [];
              vm.form.lotes.push(response);
            } else {
              vm.form.lotes = response;
            }
            angular.forEach(vm.form.lotes, function(value, key) {
              value.lote.vencimento = Date.parse(value.lote.vencimento);
            });
          }, function(response) {
            vm.status = 'Failed to load: ' + error.message;
          });
      }
    }

    function updateSelection(entry, entities) {
      angular.forEach(entities, function(subscription, index) {
        if (entry.id != subscription.id) {
          subscription.checked = false;
        }
      });
      vm.vacina = entry;
      cancelLote();
    }

    function cancelLote() {
      vm.form.lotes = [];
      vm.lote = null;
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
