(function() {
  'use strict';

  angular
    .module('Pessoa', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/pessoa/cliente', {
          templateUrl: '../static/partials/pessoa/cliente.html',
          controller: 'PessoaController',
          controllerAs: 'vm'
        })
        .when('/pessoa/funcionario', {
          templateUrl: '../static/partials/pessoa/funcionario.html',
          controller: 'PessoaController',
          controllerAs: 'vm'
        })
        .when('/pessoa/busca', {
          templateUrl: '../static/partials/pessoa/busca.html',
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
    'AnimalTemRestricaoFactory', '$filter'
  ];

  function PessoaController(PessoaFactory, $http, RedeSocialFactory, AgendaFactory,
    PorteFactory, RacaFactory, EspecieFactory, RestricaoFactory, modalService,
    dataStorage, $location, calendarConfig, FuncaoFactory, PermissaoFactory,
    PessoaTemFuncaoFactory, PessoaTemRedeSocialFactory, TelefoneFactory, AnimalFactory,
    AnimalTemRestricaoFactory, $filter
  ) {
    var vm = this;

    vm.form = {};
    vm.form.pessoa = dataStorage.getPessoa();
    console.log('pessoa init', vm.form.pessoa);
    vm.form.pessoa.funcao = "";

    vm.add = add;
    vm.alt = alt;
    vm.get = get;
    vm.del = del;
    vm.cancel = cancel;
    vm.set = set;
    vm.excluir_pessoa = excluir_pessoa;
    vm.detalhes_pessoa = detalhes_pessoa;
    vm.editar_pessoa = editar_pessoa;
    vm.gotoAddPet = gotoAddPet;

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

    if (!vm.form.pessoa.id) {
      get();
    }

    function get() {
      PessoaFactory.get()
        .then(function(response) {
          vm.pessoas = response;
          console.log('get pessoas contrl', response);
        }, function(response) {
          vm.status = 'Failed to load: ' + response.message;
        });
    }

    function updateSelection(position, entities) {
      cancel();
      angular.forEach(entities, function(subscription, index) {
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
        .then(function(result) {
          PessoaFactory.del(vm.form.pessoa.id)
            .then(function(response) {
              console.log('del pessoa', response);
            }, function(response) {
              console.error(response);
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

      // AnimalTemRestricaoFactory.get({
      //   animal_id: entry.id
      // }).then(function(response) {
      //   console.log('restricoes', response);
      //   vm.form.animal.restricoes = [];
      //   angular.forEach(response.restricao, function(value, key) {
      //     vm.form.animal.restricoes.push(value);
      //   })
      // });
      console.log('pessoa', vm.form.pessoa);
    }

    function getAnimais(entry) {
      vm.animais = {};
      if (entry.checked) {
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
            console.log('animais', vm.animais);
          }, function(response) {
            vm.status = 'Failed to load: ' + error.message;
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
        AgendaFactory.getAgendados({animal_id: entry.id})
          .then(function(response) {
            if (!angular.isArray(response.data.result)) {
              vm.historico = [];
              vm.historico.push(response.data.result);
            } else {
              vm.historico = response.data.result;
            }
            console.log('historico', vm.historico);
          }, function(response) {
            vm.status = 'Failed to load historico: ' + error.message;
          });
      }
    }

    function detalhes_pessoa(entry) {
      vm.form.pessoa = {};
      vm.form.pessoa = entry;
      TelefoneFactory.get({pessoa_id: entry.id}).then(function(response) {
        console.log(response);
        var temp = '';
        angular.forEach(response, function(value, key) {
          temp += '(' + value.codigo_area + ') '+ value.numero + '   '
        });
        vm.form.pessoa.telefone = temp;
      });
      console.log('pessoa', vm.form.pessoa);
    }

    function editar_pessoa(entry) {
      vm.form.pessoa = {};
      vm.form.pessoa = entry;
      dataStorage.addPessoa(vm.form.pessoa);
      $location.path('/pessoa/cliente');
    }

    function detalhes_animal(entry) {
      vm.form.animal = {};
      vm.form.animal = entry;
      AnimalTemRestricaoFactory.get({animal_id: entry.id}).then(function(response) {
        vm.form.animal.restricoes = response;
      });
      console.log('animal', vm.form.animal);
    }

    function editar_animal(entry) {
      vm.form.animal = {};
      vm.form.animal = entry;
      dataStorage.addPessoa(vm.form.pessoa);
      dataStorage.addAnimal(vm.form.animal);
      $location.path('/pessoa/pet');
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
          .then(function(result) {
            TelefoneFactory.del(item.id)
              .then(function(response) {
                getTelefones();
              }, function(response) {
                vm.status = 'Falha na tentativa de remover o telefone.\n' + error.message;
              });
          });
      }
    }

    function getTelefones(append) {
      if (vm.form.pessoa.id) {
        TelefoneFactory.get({
            pessoa_id: vm.form.pessoa.id
          })
          .then(function(response) {
            vm.form.telefones = response;
          }, function(response) {
            vm.status = 'Failed to load telefones: ' + error.message;
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
      if (vm.form.pessoa.id) {
        PessoaTemRedeSocialFactory.get({
            pessoa_id: vm.form.pessoa.id
          })
          .then(function(response) {
            vm.form.redesSociais = response;
            if (append) {
              vm.form.redesSociais.push({ id: null });
            }
          }, function(response) {
            vm.status = 'Failed to load: ' + error.message;
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
          .then(function(response) {
            PessoaTemRedeSocialFactory.get({
              pessoa_id: vm.form.pessoa.id
            });
          }, function(response) {
            vm.status = 'Falha na tentativa de remover a rede social.\n' + error.message;
          });
      }
    }

    function getTiposRedesSociais() {
      RedeSocialFactory.get()
        .then(function(response) {
          vm.tiposRedesSociais = response;
        }, function(response) {
          vm.status = 'Failed to load socials networks: ' + error.message;
        });
    }

    function addRedeSocial() {
      RedeSocial.add(vm.form.nomeRedeSocial)
        .then(function(response) {
          getTiposRedesSociais();
        }, function(response) {
          vm.status = 'Failed ' + error.message;
        })
    }

    function search_zip_code() {
      $http({
          url: "http://cep.republicavirtual.com.br/web_cep.php?cep=" + vm.form.pessoa.cep + "&formato=json",
          method: "GET",
          headers: {
            'Authorization': undefined
          }
        })
        .then(function(response) {
          vm.form.pessoa.pais = "Brasil";
          vm.form.pessoa.uf = response.data["uf"];
          vm.form.pessoa.cidade = response.data["cidade"];
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
      console.log(vm.form);
      return true;
    }

    function handleResponse(response) {
      console.log(response);
    }

    vm.setFuncao = function(funcao) {
      vm.form.pessoa.funcao = funcao;
    }

    function getWhatsappId() {
      RedeSocialFactory.get({
          nome: 'whatsapp'
        })
        .then(function(response) {
          vm.whatsapp_id = response.id;
        }, function(response) {
          console.log('getWhatsappId', response);
        });
    }

    function add() {
      if (validarPessoa()) {

        // adicionando a pessoa
        selectEstado();
        PessoaFactory.add(vm.form.pessoa)
          .then(function(response) {
            console.log('adicionando pessoa', response);
            if (response.data.result.id) {
              console.log('pessoa cadastrada');
              vm.status = 'Pessoa cadastrada com sucesso';
              vm.form.pessoa.id = response.data.result.id;

              // adicionando telefones
              angular.forEach(vm.form.telefones, function(value, key) {
                value.pessoa_id = vm.form.pessoa.id;

                TelefoneFactory.add(value)
                  .then(function(response) {
                    vm.status = 'Telefone cadastrado com sucesso';
                  }, function(response) {
                    handleResponse(response)
                  });

                if (value.whatsapp) {
                  var temp = {};
                  temp.perfil = value.codigo_pais + '' + value.codigo_area + '' + value.numero;
                  temp.pessoa_id = value.pessoa_id;
                  temp.rede_social_id = vm.whatsapp_id;
                  PessoaTemRedeSocialFactory.add(temp)
                    .then(function(response) {
                      vm.status = 'Whatsapp inserido';
                    });
                }
              });

              //adicionando redes sociais
              angular.forEach(vm.form.redesSociais, function(value, key) {
                value.pessoa_id = vm.form.pessoa.id;

                PessoaTemRedeSocialFactory.add(value)
                  .then(function(response) {
                    vm.status = 'Rede social cadastrado com sucesso';
                  }, function(response) {
                    handleResponse(response)
                  });
              });


              var nome_funcao = "";
              var funcao_id = 0;
              if (vm.form.pessoa.clienteEspecial) {
                nome_funcao = 'cliente-especial';
              } else {
                nome_funcao = vm.form.pessoa.funcao;
              }
              FuncaoFactory.get({
                  nome: nome_funcao
                })
                .then(function(response) {
                  funcao_id = response.id;

                  //adicionando pessoa função
                  var temp = {};
                  temp.pessoa_id = vm.form.pessoa.id;
                  temp.funcao_id = funcao_id;

                  PessoaTemFuncaoFactory.add(temp)
                    .then(function(response) {
                      vm.status = 'Pessoa função adicionada com sucesso';
                      vm.form.pessoa.pessoa_funcao_id = response.data.result.id;
                    }, function(response) {
                      console.log('erro pessoa funcao');
                      handleResponse(response)
                    });
                });

            }
          }, function(response) {
            console.log('erro pessoa');
            handleResponse(response);
          });
      }
    }

    function alt() {
      alert('alt');
    }

    function excluir_pessoa(data) {
      vm.form.pessoa = data;
      var modalOptions = {
        closeButtonText: 'Cancelar',
        actionButtonText: 'Excluir',
        actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
        .then(function(result) {
          PessoaFactory.del(vm.form.pessoa.id)
            .then(function(response) {
              console.log('del pessoa', response);
            }, function(response) {
              console.error(response);
            });
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
        .then(function(result) {
          AnimalFactory.del(vm.form.animal.id)
            .then(function(response) {
              console.log('del animal', response);
            }, function(response) {
              console.error(response);
            });
        });
    }

    function gotoAddPet() {
      add();
      dataStorage.addPessoa(vm.form.pessoa);
      $location.path('/pessoa/pet');
    }

    function getFuncoes() {
      FuncaoFactory.get()
        .then(function(response) {
          vm.funcoes = response;
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    function getPermissoes() {
      PermissaoFactory.get()
        .then(function(response) {
          vm.permissoes = response.data.result;
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    vm.selecionarPermissao = function() {
      vm.form.permissoesFuncionario = $filter('filter')(vm.permissoes, {
        checked: true
      });
      console.log('selecionando permissao', vm.form.permissoesFuncionario);
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

    function get() {
      return $http.get(_url + '/pessoa')
        .then(success)
        .catch(failed);

      function success(response) {
        console.log('get ésspa', response.data.result);
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getTelefones: ' + error.data);
      }
    }

    function add(data) {
      console.log('pessoa');
      console.log(JSON.stringify(data));
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
        console.error('Failed: ' + JSON.stringify(response));
      }
    }

    function alt(data) {
      console.log('UPDATING: ' + JSON.stringify(data));
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
        console.error('Failed: ' + JSON.stringify(response));
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
        console.error('Failed: ' + JSON.stringify(response));
      }
    }

  }

})()
