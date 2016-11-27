(function () {
  'use strict';

  angular
    .module('Funcionario', [])
    .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
        .when('/funcionario', {
          templateUrl: '../static/partials/pessoa/funcionario/novo.html',
          controller: 'FuncionarioController',
          controllerAs: 'vm'
        })
        .when('/funcionario/busca', {
          templateUrl: '../static/partials/pessoa/funcionario/busca.html',
          controller: 'FuncionarioController',
          controllerAs: 'vm'
        });
    }])
    .controller('FuncionarioController', FuncionarioController);

  FuncionarioController.$inject = ['PessoaFactory', '$http', 'RedeSocialFactory', 'AgendaFactory',
    'modalService', 'dataStorage', '$location', 'calendarConfig', 'FuncaoFactory', 'PermissaoFactory',
    'PessoaTemFuncaoFactory', 'PessoaTemRedeSocialFactory', 'TelefoneFactory', '$filter', 'ngToast',
    'PessoaTemPermissaoFactory'
  ];

  function FuncionarioController(PessoaFactory, $http, RedeSocialFactory, AgendaFactory,
    modalService, dataStorage, $location, calendarConfig, FuncaoFactory, PermissaoFactory,
    PessoaTemFuncaoFactory, PessoaTemRedeSocialFactory, TelefoneFactory, $filter, ngToast,
    PessoaTemPermissaoFactory
  ) {
    var vm = this;

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

    if (vm.form.pessoa != null && vm.form.pessoa.id != null) {
      get();
    }

    function get() {
      PessoaFactory.get()
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

      console.log('pessoa', vm.form.pessoa);
    }

    function detalhes_pessoa(entry) {
      vm.form.pessoa = {};
      vm.form.pessoa = entry;
      TelefoneFactory.get({ pessoa_id: entry.id }).then(function (response) {
        console.log(response);
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
      $location.path('/funcionario');
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
          codigo_area: '42'
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
            if (!angular.isArray(response.data.result)) {
              vm.form.redesSociais = [];
              vm.form.redesSociais.push(response.data.result);
            } else {
              vm.form.redesSociais = response.data.result;
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
      return true;
    }

    function handleResponse(response) {
      ngToast.warning({ content: '<b>Falha ao realizar a operação</b>: ' + response });
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
      if (validarPessoa()) {

        // adicionando a pessoa
        selectEstado();
        PessoaFactory.add(vm.form.pessoa)
          .then(function (response) {

            if (response.data.success != true) {
              ngToast.warning({ content: '<b>Falha ao adicionar o registro</b>: ' + response.data.mensagem });
            } else if (response.data.result.id) {
              vm.form.pessoa.id = response.data.result.id;

              // adicionando telefones
              angular.forEach(vm.form.telefones, function (value, key) {
                value.pessoa_id = vm.form.pessoa.id;

                TelefoneFactory.add(value)
                  .then(function (response) {
                    vm.status = 'Telefone cadastrado com sucesso';
                  });

                if (value.whatsapp) {
                  var temp = {};
                  temp.perfil = value.codigo_pais + '' + value.codigo_area + '' + value.numero;
                  temp.pessoa_id = value.pessoa_id;
                  temp.rede_social_id = vm.whatsapp_id;
                  PessoaTemRedeSocialFactory.add(temp)
                    .then(function (response) {
                      if (response.data.success === true) {
                        ngToast.success({ content: 'Número de Whatsapp com sucesso' });
                      } else {
                        ngToast.danger({ content: 'Falha na inclusão do número do Whatsapp' });
                      }
                    });
                }
              });

              //adicionando redes sociais
              angular.forEach(vm.form.redesSociais, function (value, key) {
                value.pessoa_id = vm.form.pessoa.id;
                value.rede_social_id = value.redeSocial;

                PessoaTemRedeSocialFactory.add(value)
                  .then(function (response) {
                    if (response.data.success === true) {
                      ngToast.success({ content: 'Rede social adicionada com sucesso' });
                    } else {
                      ngToast.danger({ content: 'Falha na inclusão da rede social' });
                    }
                  });
              });

              //adicionando pessoa função
              var temp = {};
              temp.pessoa_id = vm.form.pessoa.id;
              temp.funcao_id = vm.form.funcao;
              temp.password = vm.form.pessoa.password;

              PessoaTemFuncaoFactory.add(temp)
                .then(function (response) {
                  vm.form.pessoa.pessoa_tem_funcao_id = response.data.result.id;
                  // adicionando permissoes
                  angular.forEach(vm.form.permissoesFuncionario, function (value, key) {
                    value.pessoa_id = vm.form.pessoa.pessoa_tem_funcao_id;
                    value.permissao_id = value.id;
                    PessoaTemPermissaoFactory.add({ pessoa_id: value.pessoa_id, permissao_id: value.permissao_id }).then(function (response) {
                    });
                  });
                });
            }
          });
      }
    }

    function alt() {
      console.log('alt');
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
            .then(function (response) {
              if (response.data.success === true) {
                ngToast.success({ content: 'Registro excluído com sucesso' });
              } else {
                ngToast.danger({ content: 'Falha na exclusão do registro' });
              }
            });
        });
    }

    function getFuncoes() {
      FuncaoFactory.get()
        .then(function (response) {
          vm.funcoes = response.data.result;
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
  }

  PessoaFactory.$inject = ['$http', 'Fluffy'];

  function PessoaFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var PessoaFactory = {
      get: get,
      add: add,
      del: del,
      alt: alt
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
      return $http({
          method: 'POST',
          url: _url + '/pessoa',
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
