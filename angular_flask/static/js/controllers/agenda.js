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

  AgendaController.$inject = ['AgendaFactory', 'calendarConfig', 'modalService', '$filter', '$location', 'dataStorage'];

  function AgendaController(AgendaFactory, calendarConfig, modalService, $filter, $location, dataStorage) {
    var vm = this;

    vm.form = {};
    vm.gotoAgendamento = function() {
      $location.path('/servico/agendamento');
    }

    vm.agendamentos = [];
    vm.delAgendado = delAgendado;
    vm.editAgendado = editAgendado;
    vm.detalhes_servico = detalhes_servico;
    refreshData();

    // INIT CALENDAR
    //These variables MUST be set as a minimum for the calendar to work
    vm.calendarView = 'month';
    vm.viewDate = new Date();

    var actions = [{
      label: '<a class="btn btn-default btn-xs" data-toggle="modal" data-target="#detalhesServico"><span class="fa fa-plus"></span></a>',
      onClick: function(args) {
        vm.form = args.calendarEvent.info;
        vm.detalhes_servico();
      }
    }, {
      label: '<a class="btn btn-default btn-xs"><span class="fa fa-pencil"></span></a>',
      onClick: function(args) {
        vm.form = args.calendarEvent;
        vm.editAgendado();
      }
    }, {
      label: '<a class="btn btn-default btn-xs"><span class="fa fa-trash"></span></a>',
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
      var _duration = 30;
      AgendaFactory.getAgendados()
        .then(function(response) {
            vm.agendados = response.data.result;
            console.log('agendados', vm.agendados);

            angular.forEach(vm.agendados, function(value, key) {
              var starts = new Date(value.data_hora);
              var ends = new Date(starts.getTime() + _duration*60000);
              // title: 'Serviço: <b>' + value.servico_tem_porte.servico.nome + '</b> - Preço: <b>R$ ' + value.servico_tem_porte.preco + '</b> - Animal: <b>' + value.animal.nome + '</b>' + observacao,
              // title: '<a data-toggle="modal" data-tager="#detalhes_servico"><b>' + value.animal.nome + '</b></a>',
              vm.agendamentos.push({
                title: '<b>' + value.animal.nome + '</b>',
                startsAt: starts,
                endsAt: ends,
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
          AgendaFactory.del(vm.form.id)
            .then(function(response) {
              console.log(response);
              refreshData();
            }, function(response) {
              console.error(response);
            });
        });
    }

    function editAgendado() {
      dataStorage.addContrato(vm.form.info.servico_contratado);
      $location.path('/servico/agendamento');
    }

    function detalhes_servico() {
      // title: 'Serviço: <b>' + value.servico_tem_porte.servico.nome + '</b> - Preço: <b>R$ ' + value.servico_tem_porte.preco + '</b> - Animal: <b>' + value.animal.nome + '</b>' + observacao,
      console.log('alou', vm.form);
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
        console.error('Failed: ' + JSON.stringify(response));
      }
    }
  }

})()
