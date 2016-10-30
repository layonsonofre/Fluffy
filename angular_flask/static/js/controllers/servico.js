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
        })
        .when('/servico/agendar', {
          templateUrl: '../static/partials/servico/agendar.html',
          controller: 'ServicoController',
          controllerAs: 'vm'
        });
    }])
    .controller('ServicoController', ServicoController)
    .factory('ServicoFactory', ServicoFactory);

  ServicoController.$inject = ['ServicoFactory', 'calendarConfig', 'modalService'];

  function ServicoController(ServicoFactory, calendarConfig, modalService) {
    var vm = this;

    vm.form = null;

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    vm.agendamentos = [];
    refreshData();

    // INIT CALENDAR AND TIME PICKER
    vm.todayInicio = function() {
      vm.inicio = new Date();
    }
    vm.clearInicio = function() {
      vm.inicio = null;
    }
    vm.todayFim = function() {
      vm.fim = new Date();
    }
    vm.clearFim = function() {
      vm.fim = null;
    }
    vm.disabled = disabled;
    vm.toggleMin = toggleMin;
    vm.openInicio = function() {
      vm.popupInicio = true;
    }
    vm.openFim = function() {
      vm.popupFim = true;
    }
    vm.setDateInicio = setDateInicio;
    vm.setDateFim = setDateFim;

    vm.todayInicio();
    vm.todayFim();

    vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
    vm.format = vm.formats[0];
    vm.altInputFormats = ['d!/M!/yyyy'];

    vm.popupInicio = false;
    vm.popupFim = false;

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

    function setDateFim(year, month, day) {
      vm.fim = new Date(year, month, day);
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

    //These variables MUST be set as a minimum for the calendar to work
    vm.calendarView = 'week';
    vm.viewDate = new Date();

    var actions = [{
      label: '<a href="#" data-toggle="modal" data-target="#novoAgendamento"><span class="fa fa-pencil"></span></a>',
      onClick: function(args) {
        vm.form = args.calendarEvent.info;
      }
    }, {
      label: '<a href="#"><span class="fa fa-trash"></span></a>',
      onClick: function(args) {
        vm.form = args.calendarEvent.info;
        vm.del();
      }
    }];

    vm.cellIsOpen = true;

    vm.eventClicked = function(event) {
      alert.show('Clicked', event);
    };

    vm.eventEdited = function(event) {
      alert.show('Edited', event);
    };

    vm.eventDeleted = function(event) {
      alert.show('Deleted', event);
    };

    vm.eventTimesChanged = function(event) {
      alert.show('Dropped or resized', event);
    };

    vm.toggle = function($event, field, event) {
      $event.preventDefault();
      $event.stopPropagation();
      event[field] = !event[field];
    };

    vm.timespanClicked = function(date, cell) {
      if (vm.calendarView === 'month') {
        if ((vm.cellIsOpen && moment(date).startOf('day').isSame(moment(vm.viewDate).startOf('day'))) || cell.events.length === 0 || !cell.inMonth) {
          vm.cellIsOpen = false;
        } else {
          vm.cellIsOpen = true;
          vm.viewDate = date;
        }
      } else if (vm.calendarView === 'year') {
        if ((vm.cellIsOpen && moment(date).startOf('month').isSame(moment(vm.viewDate).startOf('month'))) || cell.events.length === 0) {
          vm.cellIsOpen = false;
        } else {
          vm.cellIsOpen = true;
          vm.viewDate = date;
        }
      }
    };
    //END INIT CALENDAR AND DATEPICKER

    function refreshData() {
      ServicoFactory.getAgendados()
        .then(function(response) {
          vm.agendados = response.data.result;

          angular.forEach(vm.agendados, function(value, key) {
            if (value.executado === false) {
              vm.agendamentos.push({
                title: 'Serviço: <b>' + value.servico_contratado + '</b> - Animal: <b>' + value.animal.nome + '</b>',
                startsAt: new Date(value.data_hora),
                endsAt: new Date(value.data_hora),
                actions: actions,
                color: calendarConfig.colorTypes.warning,
                info: value
              });
            } else {
              vm.agendamentos.push({
                title: 'Serviço: <b>' + value.servico_contratado + '</b> - Animal: <b>' + value.animal.nome + '</b>',
                startsAt: new Date(value.data_hora),
                endsAt: new Date(value.data_hora),
                actions: actions,
                color: calendarConfig.colorTypes.info,
                info: value
              });

            }
          });

        }, function(response) {
          console.error(response);
        });
    };
    // END CALENDAR AND DATEPICKER

    function get() {
      ServicoFactory.get()
        .then(function(response) {
          vm.servicos = response.data.result;
          console.log(response.data.result);
        }, function(response) {
          console.error(response);
        });
    }

    function add(data) {
      ServicoFactory.add(data).then(function(response) {
        console.log(response);
      }, function(response) {
        console.error(response)
      });
    }

    function alt(data, id) {
      ServicoFactory.alt(data, id)
        .then(function(response) {
          console.log(response.data.result);
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
          ServicoFactory.del(vm.form.id)
            .then(function(response) {
              console.log(response);
            }, function(response) {
              console.error(response);
            });
        });
    }

    function updateSelection(position, entities) {
      angular.forEach(entities, function(subscription, index) {
        if (position != index) {
          subscription.checked = false;
        }
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
      del: del,
      getAgendados: getAgendados
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
      console.log('SAVING: ' + JSON.stringify(data));
      return $http.post(
          _url + '/servico',
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

    function alt(data, id) {
      console.log('UPDATING: ' + JSON.stringify({
        id: id,
        data: data
      }));
      return $http({
          url: _url + '/servico',
          data: {
            id: id
          },
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
      return $http.delete(
          _url + '/servico',
          id
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
