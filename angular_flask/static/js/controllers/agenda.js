(function() {
  'use strict';

  angular
    .module('Agenda', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/servico/agenda', {
          templateUrl: '../static/partials/servico/agenda.html',
          controller: 'AgendaController',
          controllerAs: 'vm'
        });
    }])
    .controller('AgendaController', AgendaController)
    .factory('AgendaFactory', AgendaFactory);

  AgendaController.$inject = ['AgendaFactory', 'calendarConfig', 'modalService', '$filter'];

  function AgendaController(AgendaFactory, calendarConfig, modalService, $filter) {
    var vm = this;

    vm.form = {};

    vm.agendamentos = [];
    refreshData();

    // INIT CALENDAR
    //These variables MUST be set as a minimum for the calendar to work
    vm.calendarView = 'week';
    vm.viewDate = new Date();

    var actions = [{
      label: '<a><span class="fa fa-pencil"></span></a>',
      onClick: function(args) {
        vm.form = args.calendarEvent.info;
        vm.editAgendado();
      }
    }, {
      label: '<a><span class="fa fa-trash"></span></a>',
      onClick: function(args) {
        vm.form = args.calendarEvent.info;
        vm.delAgendado();
      }
    }];

    vm.cellIsOpen = true;

    vm.eventClicked = function(event) {
      console.log('Clicked', event);
    };

    vm.eventEdited = function(event) {
      console.log('Edited', event);
    };

    vm.eventDeleted = function(event) {
      console.log('Deleted', event);
    };

    vm.eventTimesChanged = function(event) {
      console.log('Dropped or resized', event);
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

    function refreshData() {
      AgendaFactory.getAgendados()
        .then(function(response) {
            vm.agendados = response.data.result;

            angular.forEach(vm.agendados, function(value, key) {
              vm.agendamentos.push({
                title: 'Serviço: <b>' + value.servico_contratado + '</b> - Animal: <b>' + value.animal.nome + '</b>',
                startsAt: new Date(value.data_hora),
                endsAt: new Date(value.data_hora),
                actions: actions,
                color: calendarConfig.colorTypes.warning,
                info: value
              });
            });

          },
          function(response) {
            console.error(response);
          });
    };
    // END CALENDAR

    function delAgendado() {
      var modalOptions = {
        closeButtonText: 'Cancelar',
        actionButtonText: 'Excluir',
        actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
        .then(function(result) {
          AgendaFactory.delAgendado(vm.form.id)
            .then(function(response) {
              console.log(response);
            }, function(response) {
              console.error(response);
            });
        });
    }
  }

  AgendaFactory.$inject = ['$http', 'Fluffy'];

  function AgendaFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var ServicoFactory = {
      getAgendados: getAgendados
    };
    return ServicoFactory;

    function getAgendados(data) {
      return $http({
          url: _url + '/servicoAgendado',
          data: data,
          method: 'GET'
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
