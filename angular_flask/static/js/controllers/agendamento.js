(function() {
  'use strict';

  angular
    .module('Agendamento', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/servico/agendamento', {
          templateUrl: '../static/partials/servico/agendamento.html',
          controller: 'AgendamentoController',
          controllerAs: 'vm'
        });
    }])
    .controller('AgendamentoController', AgendamentoController)
    .factory('AgendamentoFactory', AgendamentoFactory);

  AgendamentoController.$inject = ['AgendamentoFactory', 'calendarConfig', 'modalService',
                                '$filter', 'PessoaFactory'];

  function AgendamentoController(AgendamentoFactory, calendarConfig,
                                modalService, $filter, PessoaFactory) {
    var vm = this;

    vm.form = {};

    vm.get = get;
    vm.add = add;
    vm.del = del;
    vm.alt = alt;
    vm.getClientes = getClientes;
    vm.updateSelection = updateSelection;
    vm.selectCliente = selectCliente;
    vm.selectAnimal = selectAnimal;

    vm.agendamentos = [];

    get();
    getClientes();

    // INIT TIME PICKER
    vm.todayInicio = function() {
      vm.inicio = new Date();
    }
    vm.clearInicio = function() {
      vm.inicio = null;
    }
    vm.disabled = disabled;
    vm.toggleMin = toggleMin;
    vm.openInicio = function() {
      vm.popupInicio = true;
    }
    vm.setDateInicio = setDateInicio;

    vm.todayInicio();

    vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
    vm.format = vm.formats[0];
    vm.altInputFormats = ['d!/M!/yyyy'];

    vm.popupInicio = false;

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

    function setDateInicio(year, month, day) {
      vm.inicio = new Date(year, month, day);
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

    function get() {
      AgendamentoFactory.get()
        .then(function(response) {
          vm.servicos = response.data.result;
        }, function(response) {
          console.error(response);
        });
    }

    function add() {
      AgendamentoFactory.add(vm.form)
        .then(function(response) {
          vm.form.nome = null;
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data) {
      AgendamentoFactory.alt(data)
        .then(function(response) {
          get();
        }, function(response) {
          console.error(response)
        });
    }

    function del() {
      var modalOptions = {
        closeButtonText: 'Cancelar',
        actionButtonText: 'Excluir',
        actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
        .then(function(result) {
          AgendamentoFactory.del(vm.form.id)
            .then(function(response) {
              console.log(response);
            }, function(response) {
              console.error(response);
            });
        });
    }

    function getClientes() {
      PessoaFactory.getPessoas()
        .then(function(response) {
          vm.clientes = response;
        }, function(response) {
          console.error(response);
        });
    }

    function selectCliente(entry) {
      vm.form.cliente = entry;
      vm.animais = {};
      if (entry.checked) {
        PessoaFactory.getAnimais(entry.id)
          .then(function(response) {
            vm.animais = response;
          }, function(response) {
            vm.status = 'Failed to load: ' + error.message;
          });
      }
    }

    function selectAnimal(entry) {
      vm.form.animal = entry;
    }

    function updateSelection(position, entities) {
      angular.forEach(entities, function(subscription, index) {
        if (position != subscription.id) {
          subscription.checked = false;
        }
      });
    }
  }

  AgendamentoFactory.$inject = ['$http', 'Fluffy'];

  function AgendamentoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var AgendamentoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return AgendamentoFactory;

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

    function getAgendados(data) {
      return $http.get(
          _url + '/servicoAgendado',
          data
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
  }

})()
