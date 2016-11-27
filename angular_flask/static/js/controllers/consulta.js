(function () {
  'use strict';

  angular
    .module('Consulta', [])
    .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
        .when('/servico/consulta', {
          templateUrl: '../static/partials/servico/consulta.html',
          controller: 'ConsultaController',
          controllerAs: 'vm'
        });
    }])
    .controller('ConsultaController', ConsultaController)
    .factory('ConsultaFactory', ConsultaFactory);

  ConsultaController.$inject = ['ConsultaFactory', 'calendarConfig', 'modalService',
    '$filter', 'PessoaFactory', 'AnimalFactory', 'AnimalTemRestricaoFactory', 'PessoaTemFuncaoFactory',
    'ServicoTemPorteFactory', '$window', 'dataStorage', 'ServicoFactory', 'VacinaFactory', 'AgendamentoFactory',
    'AnamneseFactory'
  ];

  function ConsultaController(ConsultaFactory, calendarConfig, modalService,
    $filter, PessoaFactory, AnimalFactory, AnimalTemRestricaoFactory, PessoaTemFuncaoFactory,
    ServicoTemPorteFactory, $window, dataStorage, ServicoFactory, VacinaFactory, AgendamentoFactory,
    AnamneseFactory
  ) {
    var vm = this;

    if (!dataStorage.checkPermission('Consulta')) {
      $window.history.back();
    }

    vm.alterando = false;
    vm.updateSelection = updateSelection;
    vm.detalhes_animal = detalhes_animal;
    vm.incluirAplicacao = incluirAplicacao;
    vm.removeAplicacao = removeAplicacao;
    vm.getConsulta = getConsulta;
    vm.getVacinas = getVacinas;
    vm.alt = alt;

    vm.consulta = {};
    var agendamento = dataStorage.getAgendamento();
    if (agendamento != null) {
      vm.alterando = true;
      vm.servico_agendado_id = agendamento;
      getConsulta();
    }
    getVacinas();

    // INIT TIME PICKER
    vm.today = function (aplicacao) {
      aplicacao.data_hora = new Date();
    }
    vm.clearDate = function (aplicacao) {
      aplicacao.data_hora = null;
    }
    vm.disabled = disabled;
    vm.toggleMin = toggleMin;
    vm.openDate = function (aplicacao) {
      aplicacao.popup = true;
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

    vm.dateOptions = {
      dateDisabled: disabled,
      formatYear: 'yyyy',
      maxDate: new Date(new Date().getDate + 1),
      minDate: new Date(new Date().getDate - 30),
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

    function setDate(aplicacao, year, month, day) {
      aplicacao.data_hora = new Date(year, month, day);
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

    function incluirAplicacao() {
      getConsulta(true);
    }

    function removeAplicacao(item) {
      if (item.new === true) {
        if (vm.aplicacoes.indexOf(item) > 0) {
          vm.aplicacoes = vm.aplicacoes.splice(vm.aplicacoes.indexOf(item), 1);
          ngToast.success({ content: 'Aplicação removida' });
        } else {
          vm.aplicacoes = null;
        }

      } else {
        var modalOptions = {
          closeButtonText: 'Cancelar',
          actionButtonText: 'Excluir',
          actionButtonClass: 'btn btn-danger'
        };
        modalService.showModal({}, modalOptions)
          .then(function (result) {
            AplicacaoFactory.del(item.id)
              .then(function (response) {
                if (response.data.success === true) {
                  getAgendamentos(false);
                  ngToast.success({ content: 'Aplicação removida' });
                } else {
                  ngToast.danger({ content: 'Falha ao remover a aplicação' });
                }
              });
          });
      }
    }

    function getConsulta(append) {
      if (vm.servico_agendado_id) {
        ConsultaFactory.get({
            id: vm.servico_agendado_id
          })
          .then(function (response) {
            vm.consulta = response.data.result;

            AgendamentoFactory.getContrato({ id: vm.consulta.servico_contratado })
              .then(function (response) {
                vm.pessoa_tem_funcao = response.data.result.pessoa_tem_funcao;
              });
            vm.consulta.data_hora = new Date(vm.consulta.data_hora);
            if (!angular.isArray(response.data.result.aplicacao)) {
              vm.form.aplicacoes = [];
              vm.form.aplicacoes.push(response.data.result.aplicacao);
            } else {
              vm.form.aplicacoes = response.data.result.aplicacao;
            }
            angular.forEach(vm.form.aplicacoes, function (value, key) {
              value.data_hora = new Date(value.data_hora);
            });
          });
      }
      if (append) {
        if (!vm.aplicacoes) {
          vm.aplicacoes = [];
        }
        vm.aplicacoes.push({
          id: vm.aplicacoes.length,
          new: true,
          data_hora: new Date()
        });
      }
    }

    function detalhes_animal(animal_id) {
      AnimalFactory.get({
        id: animal_id
      }).then(function (response) {
        vm.animal = response.data.result;
        AnimalTemRestricaoFactory.get({
          animal_id: animal_id
        }).then(function (response) {
          vm.animal.restricoes = response.data.result;
        });
      });
    }

    function updateSelection(position, entities) {
      angular.forEach(entities, function (subscription, index) {
        if (position != subscription.id) {
          subscription.checked = false;
        }
      });
    }

    function getVacinas() {
      VacinaFactory.get().then(function (response) {
        vm.vacinas = response.data.result;
      });
    }

    function alt() {
      AnamneseFactory.add(vm.anamnese).then(function (response) {
        if (response.data.success === true) {
          angular.forEach(vm.aplicacoes, function (value, key) {
            value.servico_agendado_id = vm.servico_agendado_id;
            AplicacaoFactory.add(value).then(function (response) {
              if (response.data.success === true) {
                ngToast.success({ content: 'Registro alterado com sucesso' });
              } else {
                ngToast.danger({ content: 'Falha na alteração do registro' });
              }
            });
          });
        } else {
          ngToast.danger({ content: 'Falha na alteração do registro' });
        }
      });
    }
  }

  ConsultaFactory.$inject = ['$http', 'Fluffy'];

  function ConsultaFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var ConsultaFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return ConsultaFactory;

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
        return response;
      }

      function failed(response) {
        return response;
      }
    }

    function add(data) {
      console.log('insert', data);
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
        return response;
      }
    }

    function alt(data) {
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
        return response;
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
        return response;
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
        return response;
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
        return response;
      }

      function failed(response) {
        return response;
      }
    }
  }

})()
