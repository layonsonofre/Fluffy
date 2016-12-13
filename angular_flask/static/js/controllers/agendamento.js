(function () {
   'use strict';

   angular
   .module('Agendamento', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/servico/agendamento', {
         templateUrl: '../static/partials/servico/agendamento.html',
         controller: 'AgendamentoController',
         controllerAs: 'vm'
      })
      .when('/servico/lista', {
         templateUrl: '../static/partials/servico/lista.html',
         controller: 'AgendamentoController',
         controllerAs: 'vm'
      })
      .when('/servico/resumo', {
         templateUrl: '../static/partials/servico/resumo.html',
         controller: 'AgendamentoController',
         controllerAs: 'vm'
      })
      .when('/servico/taxi', {
         templateUrl: '../static/partials/servico/taxi.html',
         controller: 'AgendamentoController',
         controllerAs: 'vm'
      });
   }])
   .controller('AgendamentoController', AgendamentoController)
   .factory('AgendamentoFactory', AgendamentoFactory);

   AgendamentoController.$inject = ['AgendamentoFactory', 'calendarConfig', 'modalService',
   '$filter', 'PessoaFactory', 'AnimalFactory', 'AnimalTemRestricaoFactory', 'PessoaTemFuncaoFactory',
   'PessoaTemRedeSocialFactory', 'RedeSocialFactory', '$http', 'PorteFactory', 'RacaFactory', 'EspecieFactory', 'RestricaoFactory',
   'ServicoTemPorteFactory', '$window', 'dataStorage', 'ServicoFactory', 'ngToast', '$location'
];

function AgendamentoController(AgendamentoFactory, calendarConfig, modalService,
   $filter, PessoaFactory, AnimalFactory, AnimalTemRestricaoFactory, PessoaTemFuncaoFactory,
   PessoaTemRedeSocialFactory, RedeSocialFactory, $http, PorteFactory, RacaFactory, EspecieFactory, RestricaoFactory,
   ServicoTemPorteFactory, $window, dataStorage, ServicoFactory, ngToast, $location
) {
   var vm = this;

   if (dataStorage.getUser() == null) {
      $location.path('/login');
      ngToast.danger({content: 'Necessário realizar o login antes de utilizar esta funcionalidade'});
   }

   if (!dataStorage.checkPermission('Servico')) {
      $location.path('/erro');
      ngToast.danger({content: 'Você não tem permissão para acessar esta funcionalidade'});
   }

   vm.form = {};

   vm.alterando = false;
   vm.add = add;
   vm.del = del;
   vm.alt = alt;
   vm.getClientes = getClientes;
   vm.getFuncionarios = getFuncionarios;
   vm.updateSelection = updateSelection;
   vm.selectCliente = selectCliente;
   vm.cancelCliente = cancelCliente;
   vm.selectAnimal = selectAnimal;
   vm.calcularPreco = calcularPreco;
   vm.detalhes_animal = detalhes_animal;
   vm.incluirServico = incluirServico;
   vm.cancelAgendamento = cancelAgendamento;
   vm.getAgendamentos = getAgendamentos;
   vm.confirmar = confirmar;
   vm.adicionarCliente = adicionarCliente;
   vm.adicionarAnimal = adicionarAnimal;
   vm.selectEstado = selectEstado;
   vm.validarPessoa = validarPessoa;
   // vm.getWhatsappId = getWhatsappId;
   vm.getPortes = getPortes;
   vm.getEspecies = getEspecies;
   vm.getRestricoes = getRestricoes;
   vm.getRacas = getRacas;
   vm.gotoAgenda = gotoAgenda;
   vm.validarRegistro = validarRegistro;

   vm.getHistoricoContratos = getHistoricoContratos;
   vm.getTaxiDog = getTaxiDog;

   getPortes();
   getEspecies();
   getRestricoes();
   getRacas();

   vm.form.servicos_agendados = [];

   vm.total = 0;

   var contrato = dataStorage.getContrato();
   dataStorage.addContrato(null);
   var agendamento = dataStorage.getAgendamento();
   if (contrato != null && agendamento != null) {
      vm.alterando = true;
      vm.form.contrato = contrato;
      vm.form.servico_agendado_id = agendamento;
      getAgendamentos(false);
   }

   getServicos();
   getClientes();
   getFuncionarios();
   if (contrato === null) {
      incluirServico();
   }

   if (dataStorage.getResumo() != null) {
      vm.resumos = dataStorage.getResumo();
      dataStorage.addResumo(null);
      vm.total = 0;
      angular.forEach(vm.resumos.servicos_agendados, function(value, key) {
         value.data_hora = new Date(value.data_hora);
         vm.total += Number(value.preco);
      });
   } else {
      vm.servicos_agendados = null;
   }

   // INIT TIME PICKER
   vm.today = function (agendamento) {
      agendamento.data_hora = new Date();
   }
   vm.clearDate = function (agendamento) {
      agendamento.data_hora = null;
   }
   vm.disabled = disabled;
   vm.toggleMin = toggleMin;
   vm.openDate = function (agendamento) {
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
      .then(function (response) {
         if (response.data.success === true) {
            vm.servicos = response.data.result;
         } else {
            ngToast.danger({ content: '<b>Falha ao buscar por serviços</b>: ' + response.data.message });
         }
      });
   }

   function add() {
      vm.form.pessoa_tem_funcao_funcionario_id = dataStorage.getUser().pessoa_tem_funcao_id;
      console.log(vm.form.servicos_agendados);
      dataStorage.addResumo(vm.form);
      $location.path("/servico/resumo");
   }

   function confirmar() {
      angular.forEach(vm.resumos.servicos_agendados, function (value, key) {
         value.data_hora = new Date(value.data_hora).toISOString().substring(0, 19).replace('T', ' ');
         value.recorrente = value.recorrente ? 1 : 0;
         value.pago = value.pago ? 1 : 0;
         value.executado = value.executado ? 1 : 0;
         value.servico_id = value.servico.id;
      });
      AgendamentoFactory.add(vm.resumos)
      .then(function (response) {
         if (response.data.success != true) {
            ngToast.danger({ content: '<b>Falha ao adicionar o registro</b>: ' + response.data.message });
         } else {
            $location.path("/servico/confirmacao");
            // getAgendamentos(false);
            // ngToast.success({ content: 'Registro adicionado com sucesso' });
         }
      });
   }

   function gotoAgenda() {
      $location.path("/servico/agenda");
   }

   function alt() {
      vm.form.pessoa_tem_funcao_funcionario_id = dataStorage.getUser().pessoa_tem_funcao_id;
      angular.forEach(vm.form.servicos_agendados, function (value, key) {
         value.data_hora = new Date(value.data_hora).toISOString().substring(0, 19).replace('T', ' ');
         value.pessoa_tem_funcao_funcionario_id = vm.form.pessoa_tem_funcao_funcionario_id;
         value.animal_id = value.animal.id;
         value.recorrente = value.recorrente ? 1 : 0;
         value.pago = value.pago ? 1 : 0;
         value.executado = value.executado ? 1 : 0;

         AgendamentoFactory.alt(value)
         .then(function (response) {
            if (response.data.success != true) {
               ngToast.danger({ content: '<b>Falha ao alterar o registro</b>: ' + response.data.message });
            } else {
               ngToast.success({ content: 'Registro alterado com sucesso' });
               $location.path("/servico/agenda");
            }
         });
      });
   }

   function del() {
      var modalOptions = {
         closeButtonText: 'Cancelar',
         actionButtonText: 'Excluir',
         actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
      .then(function (result) {
         AgendamentoFactory.del(vm.form.id)
         .then(function (response) {
            if (response.data.success != true) {
               ngToast.danger({ content: '<b>Falha ao excluir o registro</b>: ' + response.data.message });
            } else {
               ngToast.success({ content: 'Registro excluído com sucesso' });
            }
         });
      });
   }

   function getClientes() {
      PessoaFactory.get({
         cliente: true
      })
      .then(function (response) {
         if (response.data.success === true) {
            vm.clientes = response.data.result;
         } else {
            ngToast.danger({ content: 'Falha ao buscar clientes'});
         }
      });
   }

   function getFuncionarios() {
      PessoaFactory.get({
         cliente: false
      })
      .then(function (response) {
         if (response.data.success === true) {
            vm.funcionarios = response.data.result;
         } else {
            ngToast.danger({ content: 'Falha ao buscar funcionários: ' + response.data.message});
         }
      });
   }

   function selectCliente(entry) {
      vm.form.pessoa_tem_funcao = entry;
      vm.animais = {};
      AnimalFactory.get({
         pessoa_id: entry.id
      })
      .then(function (response) {
         if (response.data.success === true) {
            if (!angular.isArray(response.data.result)) {
               vm.animais = [];
               vm.animais.push(response.data.result);
            } else {
               vm.animais = response.data.result;
            }
         } else {
            ngToast.danger({ content: 'Falha ao buscar os animais' });
         }
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
      }).then(function (response) {
         if (response.data.sucess === true) {
            vm.form.animal = response.data.result;
            vm.form.animal.data_nascimento = vm.form.animal.data_nascimento ? new Date(vm.form.animal.data_nascimento) : '';

            AnimalTemRestricaoFactory.get({
               animal_id: animal_id
            }).then(function (response) {
               vm.form.animal.restricoes = response.data.result;
            });
         }
      });
   }

   function calcularPreco(agendamento) {
      ServicoTemPorteFactory.get({
         porte_id: vm.form.animal.porte.id,
         servico_id: agendamento.servico.id
      })
      .then(function (response) {
         if (response != null) {
            agendamento.preco = response.preco;
            agendamento.max_preco = response.preco;
         } else {
            ngToast.danger({content: 'Falha ao calcular o valor do serviço'});
         }
      });
   }

   vm.validarPreco = function(agendamento) {
      if (agendamento.preco > agendamento.max_preco) {
         agendamento.$invalid = true;
         agendamento.maior = true;
         agendamento.preco = angular.copy(agendamento.max_preco);
      } else {
         agendamento.maior = false;
      }
   }

   vm.validarAgendamento = function(agendamento) {
      angular.forEach(vm.form.servicos_agendados, function(value, key) {
         if (agendamento.id != value.id) {
            if ((agendamento.animal_id === value.animal_id) && (new Date(agendamento.data_hora).getTime() === new Date(value.data_hora).getTime())) {
               ngToast.danger({content: 'Este animal já está com o período atribuído.'});
               agendamento.$invalid = true;
            }
         }
      });
   }

   function updateSelection(position, entities) {
      angular.forEach(entities, function (subscription, index) {
         if (position != subscription.id) {
            subscription.checked = false;
         }
      });
   }

   function incluirServico() {
      getAgendamentos(true);
   }

   function cancelAgendamento(item) {
      if (item.new === true) {
         vm.form.servicos_agendados.splice(vm.form.servicos_agendados.indexOf(item), 1)
      } else {
         var modalOptions = {
            closeButtonText: 'Fechar',
            actionButtonText: 'Cancelar',
            actionButtonClass: 'btn btn-danger'
         };
         modalService.showModal({}, modalOptions)
         .then(function (result) {
            AgendamentoFactory.alt({
               id: item.id,
               cancelado: true
            }).then(function (response) {
               getAgendamentos(false);
            });
         });

      }
   }

   function getAgendamentos(append) {
      if (vm.form.contrato != null && vm.form.servico_agendado_id != null) {
         AgendamentoFactory.get({
            id: vm.form.servico_agendado_id
         })
         .then(function (response) {
            var temp = [];
            if (!angular.isArray(response.data.result)) {
               temp.push(response.data.result);
            } else {
               temp = response.data.result;
            }
            angular.forEach(temp, function (value, key) {
               value.data_hora = Date.parse(value.data_hora);
               value.preco = value.servico_tem_porte.preco;
               value.servico_id = value.servico_tem_porte.servico.servico_id;
            });
            vm.form.servicos_agendados = temp;

            AgendamentoFactory.getContrato({
               id: vm.form.contrato
            })
            .then(function (response) {
               vm.form.pessoa_tem_funcao = response.data.result.pessoa_tem_funcao;
               vm.form.preco = response.data.result.preco;
               vm.form.transacao_id = response.data.result.transacao_id;
            })
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


   vm.openDataInicio = function () {
      vm.popupDataInicio = true;
   }
   vm.openDataFim = function () {
      vm.popupDataFim = true;
   }


   vm.selectClienteLista = selectClienteLista;
   vm.cancelClienteLista = cancelClienteLista;
   vm.selectFuncionarioLista = selectFuncionarioLista;
   vm.cancelFuncionarioLista = cancelFuncionarioLista;

   function selectClienteLista(entry) {
      vm.form.pessoa_tem_funcao_cliente = entry;
   }

   function cancelClienteLista() {
      vm.form.pessoa_tem_funcao_cliente = {};
   }

   function selectFuncionarioLista(entry) {
      vm.form.pessoa_tem_funcao_funcionario = entry;
   }

   function cancelFuncionarioLista() {
      vm.form.pessoa_tem_funcao_funcionario = {};
   }

   /**
   Tentativa de cadastro de clientes até o fim do controller
   */

   vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
   vm.format = vm.formats[0];
   vm.altInputFormats = ['d!/M!/yyyy'];

   vm.popupDataInicio = false;
   vm.popupDataFim = false;
   vm.setDate = setDate;

   function setDate(value, year, month, day) {
      value = new Date(year, month, day);
   }

   function getHistoricoContratos() {
      var data_inicio = vm.form.data_inicio ? new Date(vm.form.data_inicio).toISOString().substring(0, 19).replace('T', ' ') : null;
      var data_fim = vm.form.data_fim ? new Date(vm.form.data_fim).toISOString().substring(0, 19).replace('T', ' ') : null;
      var temp = {};
      temp.cancelado = vm.form.cancelado ? 1 : 0;
      temp.executado = vm.form.executado ? 1 : 0;
      temp.pago = vm.form.pago ? 1 : 0;
      temp.funcionario_contrato_id = vm.form.pessoa_tem_funcao_funcionario ? vm.form.pessoa_tem_funcao_funcionario.id : null;
      temp.funcionario_executa_id = vm.form.pessoa_tem_funcao_funcionario ? vm.form.pessoa_tem_funcao_funcionario.id : null;
      temp.cliente_id = vm.form.pessoa_tem_funcao_cliente ? vm.form.pessoa_tem_funcao_cliente.id : null;
      temp.data_inicio_contrato = data_inicio;
      temp.data_fim_contrato = data_fim;
      temp.data_inicio_agendamento = data_inicio;
      temp.data_fim_agendamento = data_fim;

      AgendamentoFactory.getHistoricoContratos(temp).then(function (response) {
         if (response.data.success === true) {
            console.log(response.data.result);
            if (!angular.isArray(response.data.result)) {
               vm.historicoContratos = [];
               vm.historicoContratos.push(response.data.result);
            } else {
               vm.historicoContratos = response.data.result;
            }

            angular.forEach(vm.historicoContratos, function(value, key) {
               value.data_hora = value.data_hora ? new Date(value.data_hora) : '';

               if (value.servicos_agendados ) {
                  if (!angular.isArray(value.servicos_agendados)) {
                     value.servicos_agendados = [];
                     value.servicos_agendados.push(value.servicos_agendados);
                  }
                  angular.forEach(value.servicos_agendados, function(value2, key2) {
                     value2.data_hora = value2.data_hora ? new Date(value2.data_hora) : '';
                     value2.data_hora_executado = value2.data_hora_executado ? new Date(value2.data_hora_executado) : '';
                  });
               }
            });
         } else {
            ngToast.danger({content: 'Falha ao buscar o histórico: ' + response.data.message});
         }
      });
   }


   vm.search_zip_code = search_zip_code;


   function search_zip_code() {
      $http({
         url: "http://cep.republicavirtual.com.br/web_cep.php?cep=" + vm.form.pessoa.cep + "&formato=json",
         method: "GET",
         headers: {
            'Authorization': undefined
         }
      })
      .then(function (response) {
         vm.form.pessoa.pais = "Brasil";
         vm.form.pessoa.uf = response.data["uf"];
         vm.form.pessoa.cidade = response.data["cidade"];
         vm.form.pessoa.bairro = response.data["bairro"];
         vm.form.pessoa.logradouro = response.data["tipo_logradouro"] + " " + response.data["logradouro"];
      });
   }

   function selectEstado() {
      var uf = vm.form.pessoa.uf;
      if (uf == 'AC') {
         vm.form.pessoa.estado = 'Acre';
      } else if (uf == 'AL') {
         vm.form.pessoa.estado = 'Alagoas';
      } else if (uf == 'AP') {
         vm.form.pessoa.estado = 'Amapá';
      } else if (uf == 'AM') {
         vm.form.pessoa.estado = 'Amazonas';
      } else if (uf == 'BA') {
         vm.form.pessoa.estado = 'Bahia';
      } else if (uf == 'CE') {
         vm.form.pessoa.estado = 'Ceará';
      } else if (uf == 'DF') {
         vm.form.pessoa.estado = 'Distrito Federal';
      } else if (uf == 'ES') {
         vm.form.pessoa.estado = 'Espírito Santo';
      } else if (uf == 'GO') {
         vm.form.pessoa.estado = 'Goiás';
      } else if (uf == 'MA') {
         vm.form.pessoa.estado = 'Maranhão';
      } else if (uf == 'MT') {
         vm.form.pessoa.estado = 'Mato Grosso';
      } else if (uf == 'MS') {
         vm.form.pessoa.estado = 'Mato Grosso do Sul';
      } else if (uf == 'MG') {
         vm.form.pessoa.estado = 'Minas Gerais';
      } else if (uf == 'PA') {
         vm.form.pessoa.estado = 'Pará';
      } else if (uf == 'PB') {
         vm.form.pessoa.estado = 'Paraíba';
      } else if (uf == 'PR') {
         vm.form.pessoa.estado = 'Paraná';
      } else if (uf == 'PE') {
         vm.form.pessoa.estado = 'Pernambuco';
      } else if (uf == 'PI') {
         vm.form.pessoa.estado = 'Piauí';
      } else if (uf == 'RJ') {
         vm.form.pessoa.estado = 'Rio de Janeiro';
      } else if (uf == 'RN') {
         vm.form.pessoa.estado = 'Rio Grande do Norte';
      } else if (uf == 'RS') {
         vm.form.pessoa.estado = 'Rio Grande do Sul';
      } else if (uf == 'RO') {
         vm.form.pessoa.estado = 'Rondônia';
      } else if (uf == 'RR') {
         vm.form.pessoa.estado = 'Roraima';
      } else if (uf == 'SC') {
         vm.form.pessoa.estado = 'Santa Catarina';
      } else if (uf == 'SP') {
         vm.form.pessoa.estado = 'São Paulo';
      } else if (uf == 'SE') {
         vm.form.pessoa.estado = 'Sergipe';
      } else if (uf == 'TO') {
         vm.form.pessoa.estado = 'Tocantins';
      }
   }

   function validarPessoa() {
      if (vm.form.clienteEspecial) {
         vm.form.clienteEspecial = 1;
      } else {
         vm.form.clienteEspecial = 0;
      }

      // getWhatsappId();
      return true;
   }

   vm.form.pessoa = {};

   vm.form.telefones = [];
   vm.form.telefones.push({
      id: null,
      codigo_pais: '055',
      codigo_area: '042'
   });
   //
   // vm.form.redesSociais = [];
   // vm.form.redesSociais.push({ id: null });

   // function getWhatsappId() {
   //    RedeSocialFactory.get({
   //       nome: 'whatsapp'
   //    })
   //    .then(function (response) {
   //       vm.whatsapp_id = response.data.result.id;
   //    });
   // }

   function adicionarCliente() {
      console.log(JSON.stringify(vm.form.pessoa));
      if (validarPessoa()) {
         selectEstado();

         PessoaFactory.add(vm.form)
         .then(function (response) {
            console.log(response);
            if (response.data.success != true) {
               ngToast.danger({ content: '<b>Falha ao adicionar o cliente</b>: ' + response.data.message });
            } else {
               ngToast.success({ content: 'Cliente cadastrado com sucesso' });
            }
         });
      }
   }
   function adicionarAnimal() {
      console.log(vm.form.animal);
      if (validarAnimal()) {
         AnimalFactory.add(vm.form.animal)
         .then(function (response) {
            if (response.data.success === true) {
               ngToast.success({content: 'Animal adicionado com sucesso'});
               if (response.data.result.id) {
                  selectCliente(vm.form.pessoa_tem_funcao);
                  vm.form.animal.id = response.data.result.id;

                  // adicionando restricoes
                  var temp = {};
                  temp.animal_id = vm.form.animal.id;
                  angular.forEach(vm.form.animal.restricoes, function (value, key) {
                     temp.restricao_id = value;

                     AnimalTemRestricaoFactory.add(value)
                     .then(function (response) {
                        ngToast.success({ content: 'Restrição cadastrado com sucesso' });
                     });
                  });
               }
            } else {
               ngToast.danger({ content: 'Falha ao adicionar animal: ' + response.data.message });
            }
         });
      }
   }

   vm.openNascimento = function () {
      vm.popupNascimento = true;
   }

   vm.popupNascimento = false;
   vm.setDateNascimento = setDateNascimento;

   function setDateNascimento(year, month, day) {
      vm.form.animal.data_nascimento = new Date(year, month, day);
   }

   function getPortes() {
      PorteFactory.get()
      .then(function (response) {
         vm.portes = response.data.result;
      });
   }

   function getRacas() {
      let filtro = '';
      if (vm.form.animal) {
         filtro = vm.form.animal.especie_id;
         RacaFactory.get({
            especie_id: filtro
         })
         .then(function (response) {
            vm.racas = response.data.result;
         });
      }
   }

   function getEspecies() {
      EspecieFactory.get()
      .then(function (response) {
         vm.especies = response.data.result;
      });
   }

   function getRestricoes() {
      RestricaoFactory.get()
      .then(function (response) {
         vm.restricoes = response.data.result;
      });
   }

   function validarAnimal() {
      if (!vm.form.pessoa_tem_funcao || vm.form.pessoa_tem_funcao == null) {
         ngToast.danger({content: 'Escolha o cliente antes de cadastrar um animal.'});
         return false;
      }

      vm.form.animal.pessoa_tem_funcao_cliente_id = vm.form.pessoa_tem_funcao.id;
      vm.form.animal.data_nascimento = new Date(vm.form.animal.data_nascimento).toISOString().substring(0, 19).replace('T', ' ');
      return true;
   }

   function validarRegistro() {
      if (!validarCNPJ() || !validarCPF()) {
         vm.form.pessoa.registro_erro = true;
      } else {
         vm.form = {};
      }
   }

   function validarCPF() {
      var strCPF = vm.form.pessoa.registro.replace(/[.-]/g, "");
      if (strCPF.length == 11) {
         var Soma;
         var Resto;
         var i;
         Soma = 0;
         if (strCPF == "11111111111" || strCPF == "22222222222" || strCPF == "33333333333"
         || strCPF == "44444444444" || strCPF == "55555555555" || strCPF == "66666666666"
         || strCPF == "77777777777" || strCPF == "88888888888" || strCPF == "99999999999"
         || strCPF == "00000000000") return false;

         for (i = 1; i <= 9; i++) Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (11 - i);
         Resto = (Soma * 10) % 11;

         if ((Resto == 10) || (Resto == 11)) Resto = 0;
         if (Resto != parseInt(strCPF.substring(9, 10))) return false;

         Soma = 0;
         for (i = 1; i <= 10; i++) Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (12 - i);
         Resto = (Soma * 10) % 11;

         if ((Resto == 10) || (Resto == 11)) Resto = 0;
         if (Resto != parseInt(strCPF.substring(10, 11))) return false;
         return true;
      }
   }

   function validarCNPJ() {
      var cnpj = vm.form.pessoa.registro;
      cnpj = cnpj.replace(/[^\d]+/g,'');
      if(cnpj == '')
      return false;
      if (cnpj.length != 14)
      return false;

      if (cnpj == "00000000000000" ||
      cnpj == "11111111111111" ||
      cnpj == "22222222222222" ||
      cnpj == "33333333333333" ||
      cnpj == "44444444444444" ||
      cnpj == "55555555555555" ||
      cnpj == "66666666666666" ||
      cnpj == "77777777777777" ||
      cnpj == "88888888888888" ||
      cnpj == "99999999999999")
      return false;

      tamanho = cnpj.length - 2
      numeros = cnpj.substring(0,tamanho);
      digitos = cnpj.substring(tamanho);
      soma = 0;
      pos = tamanho - 7;
      for (i = tamanho; i >= 1; i--) {
         soma += numeros.charAt(tamanho - i) * pos--;
         if (pos < 2)
         pos = 9;
      }
      resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
      if (resultado != digitos.charAt(0))
      return false;

      tamanho = tamanho + 1;
      numeros = cnpj.substring(0,tamanho);
      soma = 0;
      pos = tamanho - 7;
      for (i = tamanho; i >= 1; i--) {
         soma += numeros.charAt(tamanho - i) * pos--;
         if (pos < 2)
         pos = 9;
      }
      resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
      if (resultado != digitos.charAt(1))
      return false;

      return true;
   }



   function getTaxiDog() {
      AgendamentoFactory.getTaxiDog(vm.form)
      .then(function (response) {
         console.log(response);
         if (response.data.success === true) {
            if (!angular.isArray(response.data.servico_list)) {
               vm.taxiDog = [];
               vm.taxiDog.push(response.data.servico_list);
            } else {
               vm.taxiDog = response.data.servico_list;
            }

            angular.forEach(vm.taxiDog, function(value, key) {
               value.data_hora = value.data_hora ? new Date(value.data_hora) : null;
            });
            console.log('vm.taxiDog', vm.taxiDog);
         } else {
            ngToast.danger({ content: '<b>Falha ao buscar registros</b>: ' + response.data.message });
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
      del: del,
      getContrato: getContrato,
      getHistoricoContratos: getHistoricoContratos,
      getTaxiDog: getTaxiDog
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
         return response;
      }

      function failed(response) {
         return response;
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
         return response;
      }
   }

   function alt(data) {
      console.log("data", JSON.stringify(data));
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

   function getHistoricoContratos(data) {
      data = data || null;
      console.log(data);
      return $http({
         url: _url + '/historicoContratos',
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



   function getTaxiDog(data) {
      data = data || null;
      return $http({
         url: _url + '/taxiDog',
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
