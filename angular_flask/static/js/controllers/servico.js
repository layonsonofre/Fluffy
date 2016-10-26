(function() {
  'use strict';

  angular
    .module('Servico', [])
    .config(['$routeProvider',
      function($routeProvider) {
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
      }
    ])
    .controller('ServicoController', ServicoController)
    .factory('ServicoFactory', ServicoFactory);

  ServicoController.$inject = ['ServicoFactory', 'calendarConfig'];

  function ServicoController(ServicoFactory, calendarConfig) {
    console.log('aqui');
    var vm = this;

    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    init();

    function init() {
      ServicoFactory.getAgendados()
        .then(function(response) {
          vm.agendadosHoje = response.data.result;
          console.log(response.data.result);
        }, function(response) {
          console.error(response);
        });

    }


    ServicoFactory.get()
      .then(function(response) {
        vm.servicos = response.data.result;
        console.log(response.data.result);
      }, function(response) {
        console.error(response);
      });

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

    function del(id) {
      console.log(JSON.stringify(id));
      ServicoFactory.del(id)
        .then(function(response) {
          console.log(response);
        }, function(response) {
          console.error(response)
        });
    }

    vm.teste = 'ads';
    //These variables MUST be set as a minimum for the calendar to work
    vm.calendarView = 'week';
    vm.viewDate = moment();
    var actions = [{
      label: '<i class=\'glyphicon glyphicon-pencil\'></i>',
      onClick: function(args) {
        alert.show('Edited', args.calendarEvent);
      }
    }, {
      label: '<i class=\'glyphicon glyphicon-remove\'></i>',
      onClick: function(args) {
        alert.show('Deleted', args.calendarEvent);
      }
    }];
    vm.events = [{
      title: 'An event',
      color: calendarConfig.colorTypes.warning,
      startsAt: moment().startOf('week').subtract(2, 'days').add(8, 'hours').toDate(),
      endsAt: moment().startOf('week').add(1, 'week').add(9, 'hours').toDate(),
      draggable: true,
      resizable: true,
      actions: actions
    }, {
      title: '<i class="glyphicon glyphicon-asterisk"></i> <span class="text-primary">Another event</span>, with a <i>html</i> title',
      color: calendarConfig.colorTypes.info,
      startsAt: moment().subtract(1, 'day').toDate(),
      endsAt: moment().add(5, 'days').toDate(),
      draggable: true,
      resizable: true,
      actions: actions
    }, {
      title: 'This is a really long event title that occurs on every year',
      color: calendarConfig.colorTypes.important,
      startsAt: moment().startOf('day').add(7, 'hours').toDate(),
      endsAt: moment().startOf('day').add(19, 'hours').toDate(),
      recursOn: 'year',
      draggable: true,
      resizable: true,
      actions: actions
    }];

    vm.cellIsOpen = true;

    vm.addEvent = function() {
      vm.events.push({
        title: 'New event',
        startsAt: moment().startOf('day').toDate(),
        endsAt: moment().endOf('day').toDate(),
        color: calendarConfig.colorTypes.important,
        draggable: true,
        resizable: true
      });
    };

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

    vm.agendamentos = [];
    //
    // $scope.animais = [{
    //    'nome': 'Fluffy',
    //    'sexo': 'm',
    //    'data': '15/08/1992',
    //    'raca': 'Pastor Alemão'
    // }, {
    //    'nome': 'Bumma',
    //    'sexo': 'f',
    //    'data': '28/11/2013',
    //    'raca': 'Beagle'
    // }];
    // $scope.servicosAgendados = [];
    // $scope.removeServicosAgendados = function(index) {
    //    $scope.servicosAgendados.splice(index, 1);
    // }
    // $scope.animalAgendado = {
    //    'nome': ''
    // };
    // $scope.removeAnimalAgendado = function() {
    //    $scope.animalAgendado = {
    //       'nome': ''
    //    };
    // }
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

    function getAgendados() {
      return $http.get(
          _url + '/servicoAgendado'
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
