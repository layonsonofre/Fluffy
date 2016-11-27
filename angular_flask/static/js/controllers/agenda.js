(function () {
  'use strict';

  angular
    .module('Agenda', [])
    .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
        .when('/servico/agenda', {
          templateUrl: '../static/partials/servico/agenda.html',
          controller: 'AgendaController',
          controllerAs: 'vm'
        });
    }])
    .controller('AgendaController', AgendaController)
    .factory('AgendaFactory', AgendaFactory);

  AgendaController.$inject = ['AgendaFactory', 'calendarConfig', 'modalService', '$filter', '$location', 'dataStorage', 'ngToast'];

  function AgendaController(AgendaFactory, calendarConfig, modalService, $filter, $location, dataStorage, ngToast) {
    var vm = this;

    vm.form = {};


    vm.agendamentos = [];
    vm.delAgendado = delAgendado;
    vm.editAgendado = editAgendado;
    vm.editConsulta = editConsulta;
    vm.gotoAgendamento = gotoAgendamento;
    vm.refreshData = refreshData;

    // INIT CALENDAR
    //These variables MUST be set as a minimum for the calendar to work
    vm.calendarView = 'month';
    vm.viewDate = new Date();

    var actions = [{
      label: '<a class="btn btn-default btn-xs" data-toggle="modal" data-target="#detalhesServico"><span class="fa fa-plus"></span></a>',
      onClick: function (args) {
        vm.form = args.calendarEvent.info;
      }
    }, {
      label: '<a class="btn btn-default btn-xs"><span class="fa fa-pencil"></span></a>',
      onClick: function (args) {
        vm.form = args.calendarEvent;
        vm.editAgendado();
      }
    }, {
      label: '<a class="btn btn-default btn-xs"><span class="fa fa-trash"></span></a>',
      onClick: function (args) {
        vm.form = args.calendarEvent.info;
        vm.delAgendado();
      }
    }];

    var actionsConsulta = [{
      label: '<a class="btn btn-default btn-xs" data-toggle="modal" data-target="#detalhesServico"><span class="fa fa-plus"></span></a>',
      onClick: function (args) {
        vm.form = args.calendarEvent.info;
      }
    }, {
      label: '<a class="btn btn-default btn-xs"><span class="fa fa-stethoscope"></span></a>',
      onClick: function (args) {
        vm.form = args.calendarEvent;
        vm.editConsulta();
      }
    }];

    vm.cellIsOpen = true;

    vm.eventClicked = function (event) {
      console.log('Clicked', event);
    };

    vm.eventEdited = function (event) {
      console.log('Edited', event);
    };

    vm.eventDeleted = function (event) {
      console.log('Deleted', event);
    };

    vm.eventTimesChanged = function (event) {
      console.log('Dropped or resized', event);
    };

    vm.toggle = function ($event, field, event) {
      $event.preventDefault();
      $event.stopPropagation();
      event[field] = !event[field];
    };

    vm.timespanClicked = function (date, cell) {
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

    vm.hoje = function () {
      vm._hoje = true;
    }

    function refreshData() {
      vm.agedandados = null;
      vm.agendamentos = [];
      var _duration = 30;
      var data = vm._hoje ? $filter('date')(new Date(), 'yyyy-MM-dd') : null;
      AgendaFactory.getAgendados({ data_inicio: data, data_fim: data })
        .then(function (response) {

          if (response.data.success != true) {
            ngToast.warning({ content: '<b>Falha na consulta pelos registros</b>: ' + response.data.message });
          }

          vm.agendados = response.data.result;

          angular.forEach(vm.agendados, function (value, key) {
            value.data_hora = new Date(value.data_hora);
            var starts = new Date(value.data_hora);
            var ends = new Date(starts.getTime() + _duration * 60000);
            var executado = value.executado ? 'Executado' : 'Não executado';
            if (value.servico_tem_porte.servico.nome === 'Consulta') {
              vm.agendamentos.push({
                title: '<b>' + value.animal.nome + '</b>' + ' - ' + executado,
                startsAt: starts,
                endsAt: ends,
                actions: actionsConsulta,
                color: {
                  primary: '#0974A2',
                  secondary: '#4A9ABB'
                },
                info: value
              });
            } else {
              vm.agendamentos.push({
                title: '<b>' + value.animal.nome + '</b>' + ' - ' + executado,
                startsAt: starts,
                endsAt: ends,
                actions: actions,
                color: {
                  primary: '#FFC803',
                  secondary: '#FFDD65'
                },
                info: value
              });
            }
          });

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
        .then(function (result) {
          AgendaFactory.del(vm.form.id)
            .then(function (response) {

              if (response.data.success != true) {
                ngToast.warning({ content: '<b>Falha ao excluir o registro</b>: ' + response.data.message });
              } else {
                ngToast.success({ content: 'Registro excluído com sucesso' });
              }
              refreshData();
            });
        });
    }

    function editAgendado() {
      dataStorage.addContrato(vm.form.info.servico_contratado);
      dataStorage.addAgendamento(vm.form.info.id);
      $location.path('/servico/agendamento');
    }

    function editConsulta() {
      dataStorage.addContrato(vm.form.info.servico_contratado);
      dataStorage.addAgendamento(vm.form.info.id);
      $location.path('/servico/consulta');
    }

    function gotoAgendamento() {
      $location.path('/servico/agendamento');
    }
  }

  AgendaFactory.$inject = ['$http', 'Fluffy'];

  function AgendaFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var ServicoFactory = {
      getAgendados: getAgendados,
      del: del
    };
    return ServicoFactory;

    function getAgendados(data) {
      data = data || null;
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
        return response;
      }
    }

    function del(id) {
      return $http({
          url: _url + '/servicoAgendado',
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
        return response;
      }
    }
  }

})()
