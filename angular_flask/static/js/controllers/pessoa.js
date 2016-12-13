(function () {
   'use strict';

   angular
   .module('Pessoa', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/cliente', {
         templateUrl: '../static/partials/pessoa/cliente/novo.html',
         controller: 'PessoaController',
         controllerAs: 'vm'
      })
      .when('/cliente/busca', {
         templateUrl: '../static/partials/pessoa/cliente/busca.html',
         controller: 'PessoaController',
         controllerAs: 'vm'
      });
   }])
   .controller('PessoaController', PessoaController)
   .factory('PessoaFactory', PessoaFactory);

   PessoaController.$inject = ['PessoaFactory', '$http', 'RedeSocialFactory', 'AgendaFactory',
   'PorteFactory', 'RacaFactory', 'EspecieFactory', 'RestricaoFactory', 'modalService',
   'dataStorage', '$location', 'calendarConfig', 'FuncaoFactory', 'PermissaoFactory',
   'PessoaTemFuncaoFactory', 'PessoaTemRedeSocialFactory', 'TelefoneFactory', 'AnimalFactory',
   'AnimalTemRestricaoFactory', '$filter', 'ngToast', 'ConsultaFactory', 'AnamneseFactory', 'AplicacaoFactory'
];

function PessoaController(PessoaFactory, $http, RedeSocialFactory, AgendaFactory,
   PorteFactory, RacaFactory, EspecieFactory, RestricaoFactory, modalService,
   dataStorage, $location, calendarConfig, FuncaoFactory, PermissaoFactory,
   PessoaTemFuncaoFactory, PessoaTemRedeSocialFactory, TelefoneFactory, AnimalFactory,
   AnimalTemRestricaoFactory, $filter, ngToast, ConsultaFactory, AnamneseFactory, AplicacaoFactory
) {
   var vm = this;

   if (dataStorage.getUser() == null) {
      $location.path('/login');
      ngToast.danger({content: 'Necessário realizar o login antes de utilizar esta funcionalidade'});
   }

   if (!dataStorage.checkPermission('Cadastro')) {
      $location.path('/erro');
      ngToast.danger({content: 'Você não tem permissão para acessar esta funcionalidade'});
   }

   vm.form = {};
   vm.form.pessoa = dataStorage.getPessoa();
   dataStorage.addPessoa(null);

   vm.add = add;
   vm.alt = alt;
   vm.get = get;
   vm.del = del;
   vm.cancel = cancel;
   vm.set = set;
   vm.updateSelection = updateSelection;
   vm.excluir_pessoa = excluir_pessoa;
   vm.detalhes_pessoa = detalhes_pessoa;
   vm.editar_pessoa = editar_pessoa;
   vm.gotoAddPet = gotoAddPet;
   vm.validarRegistro = validarRegistro;

   vm.excluir_animal = excluir_animal;
   vm.detalhes_animal = detalhes_animal;
   vm.editar_animal = editar_animal;

   vm.removeTelefone = removeTelefone;
   vm.incluirTelefone = incluirTelefone;
   vm.getTelefones = getTelefones;

   vm.helpActive = false;
   vm.getPessoaRedesSociais = getPessoaRedesSociais;
   vm.getTiposRedesSociais = getTiposRedesSociais;
   vm.incluirPessoaRedeSocial = incluirPessoaRedeSocial;
   vm.addRedeSocial = addRedeSocial;

   vm.search_zip_code = search_zip_code;

   vm.getFuncoes = getFuncoes;
   vm.getPermissoes = getPermissoes;

   vm.selectEstado = selectEstado;
   vm.getWhatsappId = getWhatsappId;
   vm.getAnimais = getAnimais;
   vm.getHistorico = getHistorico;
   vm.selectAnimal = selectAnimal;
   vm.novoServico = novoServico;

   vm.detalhes_consulta = detalhes_consulta;
   vm.editar_consulta = editar_consulta;

   if (vm.form.pessoa) {
      vm.alterando = true;
   }

   get();

   function get() {
      PessoaFactory.get({ cliente: true })
      .then(function (response) {
         vm.pessoas = response.data.result;
      });
   }

   function updateSelection(position, entities) {
      cancel();
      angular.forEach(entities, function (subscription, index) {
         if (position != subscription.id) {
            subscription.checked = false;
         }
      });
   }

   function del(data) {
      vm.form.pessoa = data;
      var modalOptions = {
         closeButtonText: 'Cancelar',
         actionButtonText: 'Excluir',
         actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
      .then(function (result) {
         PessoaFactory.del(vm.form.pessoa.id)
         .then(function (response) {
            if (response.data.success === true) {
               ngToast.success({ content: 'Registro excluído com sucesso' });
            } else {
               ngToast.danger({ content: 'Falha na exclusão do registro' });
            }
         });
      });
   }

   function cancel() {
      vm.form.pessoa = {};
      vm.alterando = false;
   }

   function set(entry) {
      vm.alterando = true;
      vm.form.pessoa = entry;

      AnimalTemRestricaoFactory.get({
         animal_id: entry.id
      }).then(function (response) {
         vm.form.animal.restricoes = [];
         angular.forEach(response.data.result.restricao, function (value, key) {
            vm.form.animal.restricoes.push(value);
         })
      });
   }

   function getAnimais(entry) {
      vm.form.pessoa = entry;
      vm.animais = {};
      if (entry.checked) {
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

               angular.forEach(vm.animais, function(value, key) {
                  value.data_nascimento = value.data_nascimento ? new Date(value.data_nascimento) : '';
               });
            } else {
               ngToast.danger({ content: 'Falha na busca pelos registros' });
            }
         });
      }
   }

   function selectAnimal(entry) {
      dataStorage.animal = entry;
      getHistorico(entry);
   }

   function getHistorico(entry) {
      vm.historico = {};
      if (entry.checked) {
         AgendaFactory.getAgendados({ animal_id: entry.id })
         .then(function (response) {
            console.log(response);
            if (response.data.success === true) {
               if (!angular.isArray(response.data.result)) {
                  vm.historico = [];
                  vm.historico.push(response.data.result);
               } else {
                  vm.historico = response.data.result;
               }
               angular.forEach(vm.historico, function(value, key) {
                  value.data_hora = value.data_hora ? $filter('date')(new Date(value.data_hora), 'dd/MM/yyyy HH:mm') : null;
                  value.data_hora_executado = value.data_hora_executado ? $filter('date')(new Date(value.data_hora_executado), 'dd/MM/yyyy HH:mm') : null;
               });
            } else {
               ngToast.danger({ content: 'Falha na busca pelos registros' });
            }
         });
      }
   }

   function detalhes_pessoa(entry) {
      vm.form.pessoa = {};
      vm.form.pessoa = entry;
      TelefoneFactory.get({ pessoa_id: entry.id }).then(function (response) {
         var temp = '';
         angular.forEach(response.data.result, function (value, key) {
            temp += '(' + value.codigo_area + ') ' + value.numero + '   '
         });
         vm.form.pessoa.telefone = temp;
      });
   }

   function editar_pessoa(entry) {
      vm.form.pessoa = {};
      vm.form.pessoa = entry;
      dataStorage.addPessoa(vm.form.pessoa);
      $location.path('/cliente');
   }

   function detalhes_animal(entry) {
      vm.form.animal = {};
      vm.form.animal = angular.copy(entry);
      vm.form.animal.data_nascimento = new Date(vm.form.animal.data_nascimento);
      AnimalTemRestricaoFactory.get({ animal_id: entry.id }).then(function (response) {
         if (response.data.success === true) {
            if (!angular.isArray(response.data.result)) {
               vm.form.animal.restricoes = [];
               vm.form.animal.restricoes.push(response.data.result);
            } else {
               vm.form.animal.restricoes = response.data.result;
            }
         } else {
            ngToast.danger({ content: 'Falha na busca pelo registro' });
         }
      });
   }

   function editar_animal(entry) {
      vm.form.animal = {};
      vm.form.animal = entry;
      dataStorage.addPessoa(vm.form.pessoa);
      dataStorage.addAnimal(vm.form.animal);
      $location.path('/cliente/pet');
   }



   function detalhes_consulta(entry) {
      console.log('entry', entry);
      vm.form.consulta = {};
      ConsultaFactory.get({ id: entry.id }).then(function (response) {
         console.log('consulta', response);
         vm.form.consulta = response.data.result;
         AnamneseFactory.get({servico_agendado_id: entry.id}).then(function (response) {
            console.log('anamnese', response);
            vm.form.consulta.anamnese = response.data.result;
            AplicacaoFactory.get({servico_agendado_id: entry.id}).then(function (response) {
               console.log('aplicacao', response);
               if (!angular.isArray(response.data.result)) {
                  vm.form.consulta.aplicacoes = [];
                  vm.form.consulta.aplicacoes.push(response.data.result);
               } else {
                  vm.form.consulta.aplicacoes = response.data.result;
               }
            })
         });
      });
   }

   function editar_consulta(entry) {
      console.log(entry);
      // vm.form.animal = {};
      // vm.form.animal = entry;
      // dataStorage.addPessoa(vm.form.pessoa);
      // dataStorage.addAnimal(vm.form.animal);
      // $location.path('/cliente/pet');
   }

   function novoServico() {
      $location.path("/servico/agendamento");
   }

   getTiposRedesSociais();
   vm.status = null;

   incluirTelefone();
   incluirPessoaRedeSocial();

   getFuncoes();
   getPermissoes();

   vm.whatsapp_id = {};
   getWhatsappId();

   function incluirTelefone() {
      getTelefones(true);
   }

   function removeTelefone(item) {
      if (item.id === null) {
         vm.form.telefones = vm.form.telefones.splice(vm.form.telefones.indexOf(item), 1)
      } else {
         var modalOptions = {
            closeButtonText: 'Cancelar',
            actionButtonText: 'Excluir',
            actionButtonClass: 'btn btn-danger'
         };
         modalService.showModal({}, modalOptions)
         .then(function (result) {
            TelefoneFactory.del(item.id)
            .then(function (response) {
               getTelefones();
            });
         });
      }
   }

   function getTelefones(append) {
      if (vm.form.pessoa != null && vm.form.pessoa.id != null) {
         TelefoneFactory.get({
            pessoa_id: vm.form.pessoa.id
         })
         .then(function (response) {
            vm.form.telefones = response.data.result;
         });
      }
      if (append) {
         if (!vm.form.telefones) {
            vm.form.telefones = [];
         }
         vm.form.telefones.push({
            id: null,
            codigo_pais: '055',
            codigo_area: '042'
         });
      }
   }

   function incluirPessoaRedeSocial() {
      getPessoaRedesSociais(true);
   }

   function getPessoaRedesSociais(append) {
      if (vm.form.pessoa != null && vm.form.pessoa.id != null) {
         PessoaTemRedeSocialFactory.get({
            pessoa_id: vm.form.pessoa.id
         })
         .then(function (response) {
            if (response.data.success === true) {
               if (!angular.isArray(response.data.result)) {
                  vm.form.redesSociais = [];
                  vm.form.redesSociais.push(response.data.result);
               } else {
                  vm.form.redesSociais = response.data.result;
               }
            } else {
               ngToast.danger({ content: 'Falha na busca pelo registro' });
            }
            if (append) {
               vm.form.redesSociais.push({ id: null });
            }
         });
      }
      if (append) {
         if (!vm.form.redesSociais) {
            vm.form.redesSociais = [];
         }
         vm.form.redesSociais.push({ id: null });
      }
   }

   function removeRedeSocial(item) {
      if (item.id === null) {
         vm.form.redesSociais = vm.form.redesSociais.splice(vm.form.redesSociais.indexOf(item), 1)
      } else {
         PessoaTemRedeSocialFactory.del(item.id)
         .then(function (response) {
            getPessoaRedesSociais(false);
         });
      }
   }

   function getTiposRedesSociais() {
      RedeSocialFactory.get()
      .then(function (response) {
         vm.tiposRedesSociais = response.data.result;
      });
   }

   function addRedeSocial() {
      RedeSocial.add(vm.form.nomeRedeSocial)
      .then(function (response) {
         getTiposRedesSociais();
      });
   }

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
      if (vm.form.pessoa.clienteEspecial) {
         vm.form.pessoa.clienteEspecial = 1;
      } else {
         vm.form.pessoa.clienteEspecial = 0;
      }

      getWhatsappId();
      return true;
   }

   vm.setFuncao = function (funcao) {
      vm.form.pessoa.funcao = funcao;
   }

   function getWhatsappId() {
      RedeSocialFactory.get({
         nome: 'whatsapp'
      })
      .then(function (response) {
         vm.whatsapp_id = response.data.result.id;
      });
   }



   function add() {
      if (vm.alterando) {
         alt();
      } else {
         if (validarPessoa()) {
            selectEstado();
            angular.forEach(vm.telefones, function (value, key) {
               if (value.whatsapp) {
                  var temp = {};
                  temp.perfil = value.codigo_pais + '' + value.codigo_area + '' + value.numero;
                  temp.rede_social_id = vm.whatsapp_id;
                  vm.form.redesSociais.push({perfil: temp.perfil, rede_social_id: vm.whatsapp_id});
               }
            });

            PessoaFactory.add(vm.form)
            .then(function (response) {
               if (response.data.success != true) {
                  ngToast.danger({ content: '<b>Falha ao adicionar o registro</b>: ' + response.data.message });
               } else {
                  vm.form = {};
                  vm.incluirTelefone();
                  vm.incluirPessoaRedeSocial();
                  vm.form.pessoa.id = response.data.result.id;
                  ngToast.success({ content: 'Cliente cadastrado com sucesso' });
               }
            });
         }
      }
   }

   function alt() {
      if (validarPessoa()) {

         // adicionando a pessoa
         selectEstado();
         PessoaFactory.alt(vm.form.pessoa)
         .then(function (response) {

            if (response.data.success != true) {
               ngToast.danger({ content: '<b>Falha ao alterar o registro</b>: ' + response.data.message });
            } else if (response.data.result.id) {

               // adicionando telefones
               angular.forEach(vm.form.telefones, function (value, key) {
                  value.pessoa_id = vm.form.pessoa.id;

                  TelefoneFactory.alt(value)
                  .then(function (response) {
                     if (response.data.success === true) {
                        ngToast.success({ content: 'Telefone alterado com sucesso' });
                     } else {
                        ngToast.danger({ content: 'Falha na alteração do telefone' });
                     }
                  });

                  if (value.whatsapp) {
                     var temp = {};
                     temp.perfil = value.codigo_pais + '' + value.codigo_area + '' + value.numero;
                     temp.pessoa_id = value.pessoa_id;
                     temp.rede_social_id = vm.whatsapp_id;
                     PessoaTemRedeSocialFactory.alt(temp)
                     .then(function (response) {
                        if (response.data.success === true) {
                           ngToast.success({ content: 'Número de Whatsapp alterado com sucesso' });
                        } else {
                           ngToast.danger({ content: 'Falha na alteração do número do Whatsapp' });
                        }
                     });
                  }
               });

               angular.forEach(vm.form.redesSociais, function (value, key) {
                  value.pessoa_id = vm.form.pessoa.id;
                  value.rede_social_id = value.redeSocial;

                  PessoaTemRedeSocialFactory.alt(value)
                  .then(function (response) {
                     if (response.data.success === true) {
                        ngToast.success({ content: 'Rede social alterada com sucesso' });
                     } else {
                        ngToast.danger({ content: 'Falha na alteração da rede social' });
                     }
                  });
               });
            }
         });
      }
   }

   function excluir_pessoa(data) {
      vm.form.pessoa = data;
      var modalOptions = {
         closeButtonText: 'Cancelar',
         actionButtonText: 'Excluir',
         actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
      .then(function (result) {
         PessoaFactory.del(vm.form.pessoa.id)
         .then(function (response) {});
      });
   }

   function excluir_animal(data) {
      vm.form.pessoa = data;
      var modalOptions = {
         closeButtonText: 'Cancelar',
         actionButtonText: 'Excluir',
         actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
      .then(function (result) {
         AnimalFactory.del(vm.form.animal.id)
         .then(function (response) {});
      });
   }

   function gotoAddPet() {
      add();
      dataStorage.addPessoa(vm.form.pessoa);
      $location.path('/cliente/pet');
   }

   function getFuncoes() {
      FuncaoFactory.get()
      .then(function (response) {
         vm.funcoes = response;
      });
   }

   function getPermissoes() {
      PermissaoFactory.get()
      .then(function (response) {
         vm.permissoes = response.data.result;
      });
   }

   vm.selecionarPermissao = function () {
      vm.form.permissoesFuncionario = $filter('filter')(vm.permissoes, {
         checked: true
      });
   };

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
}

PessoaFactory.$inject = ['$http', 'Fluffy'];

function PessoaFactory($http, Fluffy) {
   var _url = Fluffy.urlBase;
   var PessoaFactory = {
      get: get,
      add: add,
      del: del,
      alt: alt,
      addFuncionario: addFuncionario,
      addAdmin: addAdmin
   };
   return PessoaFactory;

   function get(data) {
      data = data || null;
      return $http({
         url: _url + '/pessoa',
         method: 'GET',
         params: data
      })
      .then(success)
      .catch(failed);

      function success(response) {
         return response;
      }

      function failed(error) {
         return error;
      }
   }

   function add(data) {
      console.log(JSON.stringify(data));
      return $http({
         method: 'POST',
         url: _url + '/insertCliente',
         data: data
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

   function addFuncionario(data) {
      console.log(data);
      return $http({
         method: 'POST',
         url: _url + '/insertFuncionario',
         data: data
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

   function addAdmin(data) {
      console.log(data);
      return $http({
         method: 'POST',
         url: _url + '/insertAdministrador',
         data: data
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
         url: _url + '/pessoa',
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
         url: _url + '/pessoa',
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
