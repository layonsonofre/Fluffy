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
    '$filter', 'PessoaFactory', 'AnimalFactory', 'AnimalTemRestricaoFactory', 'PessoaTemFuncaoFactory',
    'ServicoTemPorteFactory', '$window', 'dataStorage', 'ServicoFactory'
  ];

  function AgendamentoController(AgendamentoFactory, calendarConfig, modalService,
    $filter, PessoaFactory, AnimalFactory, AnimalTemRestricaoFactory, PessoaTemFuncaoFactory,
    ServicoTemPorteFactory, $window, dataStorage, ServicoFactory
  ) {
    var vm = this;

    if (!dataStorage.checkPermission('Servico')) {
      $window.history.back();
    }

    vm.form = {};
    vm.alterando = false;
    vm.add = add;
    vm.del = del;
    vm.alt = alt;
    vm.getClientes = getClientes;
    vm.updateSelection = updateSelection;
    vm.selectCliente = selectCliente;
    vm.cancelCliente = cancelCliente;
    vm.selectAnimal = selectAnimal;
    vm.calcularPreco = calcularPreco;
    vm.detalhes_animal = detalhes_animal;
    vm.incluirAgendamento = incluirAgendamento;
    vm.removeAgendamento = removeAgendamento;
    vm.getAgendamentos = getAgendamentos;

    vm.form.servicos_agendados = [];
    var contrato = dataStorage.getContrato();
    dataStorage.addContrato("");
    var agendamento = dataStorage.getAgendamento();
    if (contrato != null && agendamento != null) {
      vm.alterando = true;
      vm.form.contrato = contrato;
      vm.form.servico_agendado_id = agendamento;
      getAgendamentos(false);
    }

    getServicos();
    getClientes();
    if (contrato === null) {
      incluirAgendamento();
    }

    // INIT TIME PICKER
    vm.today = function(agendamento) {
      agendamento.data_hora = new Date();
    }
    vm.clearDate = function(agendamento) {
      agendamento.data_hora = null;
    }
    vm.disabled = disabled;
    vm.toggleMin = toggleMin;
    vm.openDate = function(agendamento) {
      agendamento.popup = true;
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

    function setDate(agendamento, year, month, day) {
      agendamento.data_hora = new Date(year, month, day);
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

    function getServicos() {
      ServicoFactory.get()
        .then(function(response) {
          vm.servicos = response.data.result;
        }, function(response) {
          console.error(response);
        });
    }

    function add() {
      vm.form.pessoa_tem_funcao_funcionario_id = 3;
      angular.forEach(vm.form.servicos_agendados, function(value, key) {
        value.data_hora = new Date(value.data_hora).toISOString().substring(0, 19).replace('T', ' ');
      });
      AgendamentoFactory.add(vm.form)
        .then(function(response) {
          getAgendamentos(false);
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt() {
      vm.form.pessoa_tem_funcao_funcionario_id = 3;
      angular.forEach(vm.form.servicos_agendados, function(value, key) {
        value.data_hora = new Date(value.data_hora).toISOString().substring(0, 19).replace('T', ' ');
        value.pessoa_tem_funcao_funcionario_id = vm.form.pessoa_tem_funcao_funcionario_id;
        value.animal_id = value.animal.id;

        console.log("value", value);
        // AgendamentoFactory.alt(value)
        //   .then(function(response) {
        //     getAgendamentos(false);
        //   }, function(response) {
        //     vm.status = response.message
        //   });
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
            .then(function(response) {}, function(response) {
              console.error(response);
            });
        });
    }

    function getClientes() {
      PessoaTemFuncaoFactory.get()
        .then(function(response) {
          vm.clientes = response;
        }, function(response) {
          console.error(response);
        });
    }

    function selectCliente(entry) {
      vm.form.pessoa_tem_funcao = entry;
      vm.animais = {};
      AnimalFactory.get({
          pessoa_id: entry.id
        })
        .then(function(response) {
          if (!angular.isArray(response)) {
            vm.animais = [];
            vm.animais.push(response);
          } else {
            vm.animais = response;
          }
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    function cancelCliente() {
      vm.form.pessoa_tem_funcao = {};
    }

    function selectAnimal(agendamento, entry) {
      vm.form.animal = entry;
      agendamento.animal_id = entry.id;
    }

    function detalhes_animal(animal_id) {
      AnimalFactory.get({
        id: animal_id
      }).then(function(response) {
        vm.form.animal = response;
        AnimalTemRestricaoFactory.get({
          animal_id: animal_id
        }).then(function(response) {
          vm.form.animal.restricoes = response;
        });
      });
    }

    function calcularPreco(agendamento) {
      ServicoTemPorteFactory.get({
          porte_id: vm.form.animal.porte.id,
          servico_id: agendamento.servico_id
        })
        .then(function(response) {
          agendamento.preco = response.preco;
        });
    }

    function updateSelection(position, entities) {
      angular.forEach(entities, function(subscription, index) {
        if (position != subscription.id) {
          subscription.checked = false;
        }
      });
    }

    function incluirAgendamento() {
      getAgendamentos(true);
    }

    function removeAgendamento(item) {
      if (item.new === true) {
        vm.form.servicos_agendados = vm.form.servicos_agendados.splice(vm.form.servicos_agendados.indexOf(item), 1)
      } else {
        var modalOptions = {
          closeButtonText: 'Cancelar',
          actionButtonText: 'Excluir',
          actionButtonClass: 'btn btn-danger'
        };
        modalService.showModal({}, modalOptions)
          .then(function(result) {
            AgendamentoFactory.del(item.id)
              .then(function(response) {
                getAgendamentos(false);
              }, function(response) {
                vm.status = 'Falha na tentativa de remover o agendamento.\n' + error.message;
              });
          });
      }
    }

    function getAgendamentos(append) {
      if (vm.form.contrato && vm.form.servico_agendado_id) {
        AgendamentoFactory.get({
            id: vm.form.servico_agendado_id
          })
          .then(function(response) {
            var temp = [];
            if (!angular.isArray(response)) {
              temp.push(response);
            } else {
              temp = response;
            }
            angular.forEach(temp, function(value, key) {
              value.data_hora = Date.parse(value.data_hora);
              value.preco = value.servico_tem_porte.preco;
              value.servico_id = value.servico_tem_porte.servico.servico_id;
            });
            vm.form.servicos_agendados = temp;

            AgendamentoFactory.getContrato({
                id: vm.form.contrato
              })
              .then(function(response) {
                vm.form.pessoa_tem_funcao = response.pessoa_tem_funcao;
                vm.form.preco = response.preco;
                vm.form.transacao_id = response.transacao_id;
              })
          }, function(response) {
            vm.status = 'Failed to load: ' + error.message;
          });
      }
      if (append) {
        if (!vm.form.servicos_agendados) {
          vm.form.servicos_agendados = [];
        }
        vm.form.servicos_agendados.push({
          id: vm.form.servicos_agendados.length,
          new: true
        });
      }
    }
  }

  AgendamentoFactory.$inject = ['$http', 'Fluffy'];

  function AgendamentoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var AgendamentoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del,
      getContrato: getContrato
    };
    return AgendamentoFactory;

    function get(data) {
      data = data || null;
      return $http({
          url: _url + '/servicoAgendado',
          params: data,
          method: 'GET'
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(response) {
        console.error('Failed: ' + JSON.stringify(response));
      }
    }

    function add(data) {
      return $http({
          url: _url + '/insertServicoAgendado',
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
      console.log("data", data);
      return $http({
          url: _url + '/servicoAgendado',
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

    function getContrato(data) {

      data = data || null;
      return $http({
          url: _url + '/servicoContratado',
          params: data,
          method: 'GET'
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(response) {
        console.error('Failed: ' + JSON.stringify(response));
      }
    }
  }

})()
