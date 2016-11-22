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

  VacinaController.$inject = ['VacinaFactory', 'LoteFactory', 'modalService', 'calendarConfig'];

  function VacinaController(VacinaFactory, LoteFactory, modalService, calendarConfig) {
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

    vm.today = function(lote) {
      lote.vencimento = new Date();
    }
    vm.clearDate = function(lote) {
      lote.data_hora = null;
    }
    vm.disabled = disabled;
    vm.toggleMin = toggleMin;
    vm.openDate = function(lote) {
      lote.popup = true;
    }
    vm.setDate = setDate;

    vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
    vm.format = vm.formats[0];
    vm.altInputFormats = ['d!/M!/yyyy'];

    vm.inlineOptions = {
      customClass: getDayClass,
      minDate: new Date(),
      showWeeks: true
    };

    vm.oneYearFromNow = new Date();
    vm.oneYearFromNow.setDate(vm.oneYearFromNow.getDate() + 1);

    vm.oneMonthAgo = new Date();
    vm.oneMonthAgo.setDate(vm.oneMonthAgo.getDate() - 30);

    vm.dateOptions = {
      dateDisabled: disabled,
      formatYear: 'yyyy',
      maxDate: vm.oneYearFromNow,
      minDate: vm.oneMonthAgo,
      startingDay: 1
    }

    //disabled weekend selection
    function disabled(data) {
      var date = data.date,
        mode = data.mode;
      return mode == 'day' && (date.getDay() === 0 || date.getDay() === 6);
    }

    function toggleMin() {
      vm.inlineOptions.minDate = vm.inlineOptions.minDate ? null : new Date();
      vm.dateOptions.minDate = vm.inlineOptions.minDate;
    }

    vm.toggleMin();

    function setDate(lote, year, month, day) {
      lote.vencimento = new Date(year, month, day);
    }

    function getDayClass(data) {
      var date = data.date,
        mode = data.mode;
      if (mode === 'day') {
        var dayToCheck = new Date(date).setHours(0, 0, 0, 0);

        for (var i = 0; i < vm.events.length; i++) {
          var currentDay = new Date(vm.events[i].date).setHours(0, 0, 0, 0);

          if (dayToCheck === currentDay) {
            return vm.events[i].status;
          }
        }
      }
      return '';
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
