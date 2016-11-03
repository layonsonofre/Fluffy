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
        .when('/pessoa/pet', {
          templateUrl: '../static/partials/pessoa/pet.html',
          controller: 'PessoaController',
          controllerAs: 'vm'
        })
        .when('/pessoa/busca', {
          templateUrl: '../static/partials/pessoa/busca.html',
          controller: 'PessoaController',
          controllerAs: 'vm'
        })
    }])
    .controller('PessoaController', PessoaController)
    .factory('PessoaFactory', PessoaFactory);

  PessoaController.$inject = ['PessoaFactory', '$http', 'RedeSocialFactory', 'ServicoFactory', 'PorteFactory', 'RacaFactory', 'EspecieFactory', 'RestricaoFactory', 'modalService', 'dataStorage', '$location', 'calendarConfig', 'FuncaoFactory', 'PermissaoFactory', '$filter'];

  function PessoaController(PessoaFactory, $http, RedeSocialFactory, ServicoFactory, PorteFactory, RacaFactory, EspecieFactory, RestricaoFactory, modalService, dataStorage, $location, calendarConfig, FuncaoFactory, PermissaoFactory, $filter) {
    var vm = this;

    vm.form = dataStorage.getPessoa();

    vm.add = add;
    vm.alt = alt;
    vm.excluir_pessoa = excluir_pessoa;
    vm.gotoAddPet = gotoAddPet;

    vm.removeTelefone = removeTelefone;
    vm.incluirTelefone = incluirTelefone;
    vm.getTelefones = getTelefones;

    vm.helpActive = false;
    vm.getPessoaRedesSociais = getPessoaRedesSociais;
    vm.getTiposRedesSociais = getTiposRedesSociais;
    vm.incluirPessoaRedeSocial = incluirPessoaRedeSocial;
    vm.addRedeSocial = addRedeSocial;

    vm.getPessoas = getPessoas;
    vm.getAnimais = getAnimais;
    vm.getHistorico = getHistorico;
    vm.selectAnimal = selectAnimal;
    vm.novoServico = novoServico;
    vm.updateSelection = updateSelection;

    vm.getPortes = getPortes;
    vm.getEspecies = getEspecies;
    vm.getRestricoes = getRestricoes;
    vm.getRacas = getRacas;

    vm.adicionarAnimal = false;

    vm.showAdicionarTelefone = false;
    vm.showAdicionarAnimal = showAdicionarAnimal;
    vm.search_zip_code = search_zip_code;

    vm.getFuncoes = getFuncoes;
    vm.getPermissoes = getPermissoes;

    getTiposRedesSociais();
    getPessoas();
    vm.status = null;
    vm.filtro = vm.form.nome;

    getPortes();
    getEspecies();
    getRestricoes();
    getRacas();

    incluirTelefone();
    incluirPessoaRedeSocial();

    getFuncoes();
    getPermissoes();

    function incluirTelefone() {
      vm.form.pessoa_id = null;
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
            PessoaFactory.delTelefone(item.id)
              .then(function(response) {
                getTelefones();
              }, function(response) {
                vm.status = 'Falha na tentativa de remover o telefone.\n' + error.message;
              });
          });
      }
    }

    function getTelefones(append) {
      if (vm.form.pessoa_id) {
        PessoaFactory.getTelefones(vm.form.pessoa_id)
          .then(function(response) {
            vm.form.telefones = response;
          }, function(response) {
            vm.status = 'Failed to load telefones: ' + error.message;
          });
      } else {
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
    }

    function incluirPessoaRedeSocial() {
      getPessoaRedesSociais(true);
    }

    function getPessoaRedesSociais(append) {
      if (vm.form.pessoa_id) {
        PessoaFactory.getPessoaRedesSociais(vm.form.pessoa_id)
          .then(function(response) {
            vm.form.redesSociais = response;
          }, function(response) {
            vm.status = 'Failed to load: ' + error.message;
          });
      } else {
        if (append) {
          if (!vm.form.redesSociais) {
            vm.form.redesSociais = [];
          }
          vm.form.redesSociais.push({
            id: null
          });
        }
      }
    }

    function removeRedeSocial(item) {
      if (item.id === null) {
        vm.form.redesSociais = vm.form.redesSociais.splice(vm.form.redesSociais.indexOf(item), 1)
      } else {
        PessoaFactory.delPessoaSocial(item.id)
          .then(function(response) {
            getRedesSociais();
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

    function getPessoas() {
      PessoaFactory.getPessoas()
        .then(function(response) {
          vm.pessoas = response;
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    function getAnimais(entry) {
      vm.animais = {};
      if (entry.checked) {
        PessoaFactory.getAnimais(entry.id)
          .then(function(response) {
            vm.animais = response;
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
        ServicoFactory.getAgendados(entry.id)
          .then(function(response) {
            vm.historico = response;
          }, function(response) {
            vm.status = 'Failed to load historico: ' + error.message;
          });
      }
    }

    function showAdicionarAnimal() {
      vm.adicionarAnimal = (vm.adicionarAnimal == true) ? false : true;
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
          vm.form.pessoa.estado = response.data["uf"];
          vm.form.pessoa.cidade = response.data["cidade"];
          vm.form.pessoa.logradouro = response.data["tipo_logradouro"] + " " + response.data["logradouro"];
        });
    }

    function validarPessoa() {
      return true;
    }


    function add() {
      if (validarPessoa()) {
        PessoaFactory.add(vm.form.pessoa)
          .then(function(response) {
            console.log(response);
          }, function(response) {
            console.error(response)
          });
      }
      console.log("SAVING: " + JSON.stringify(vm.form.pessoa));
      console.log("SAVING: " + JSON.stringify(vm.form.redesSociais));
      console.log("SAVING: " + JSON.stringify(vm.form.telefones));
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
              console.log(response);
            }, function(response) {
              console.error(response);
            });
        });
    }

    function novoServico() {
      $location.path("/servico");
    }

    function gotoAddPet() {
      dataStorage.addPessoa(vm.form.pessoa);
      $location.path('/pessoa/pet');
    }

    function updateSelection(position, entities) {
      angular.forEach(entities, function(subscription, index) {
        if (position != index) {
          subscription.checked = false;
        }
      });
    }


    vm.openNascimento = function() {
      vm.popupNascimento = true;
    }

    vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
    vm.format = vm.formats[0];
    vm.altInputFormats = ['d!/M!/yyyy'];

    vm.popupNascimento = false;
    vm.setDateNascimento = setDateNascimento;

    function setDateNascimento(year, month, day) {
      vm.form.animal.data_nascimento = new Date(year, month, day);
    }

    function getPortes() {
      PorteFactory.get()
        .then(function(response) {
          vm.portes = response;
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    function getRacas() {
      RacaFactory.get()
        .then(function(response) {
          vm.racas = response;
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    function getEspecies() {
      EspecieFactory.get()
        .then(function(response) {
          vm.especies = response;
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    function getRestricoes() {
      RestricaoFactory.get()
        .then(function(response) {
          vm.restricoes = response;
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
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
      vm.form.permissoesFuncionario = $filter('filter')(vm.permissoes, {checked: true});
      console.log(vm.form.permissoesFuncionario);
    };
  }

  PessoaFactory.$inject = ['$http', 'Fluffy'];

  function PessoaFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var PessoaFactory = {
      getRedesSociais: getRedesSociais,
      getTelefones: getTelefones,
      getPessoas: getPessoas,
      getAnimais: getAnimais,
      getHistorico: getHistorico,
      getServicosAgendados: getServicosAgendados,
      add: add,
      delTelefone: delTelefone,
      del: del,
      getPessoaRedesSociais: getPessoaRedesSociais
    };
    return PessoaFactory;

    function getRedesSociais() {
      return $http.get(_url + '/redeSocial')
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getRedesSociais: ' + error.data);
      }
    }

    function getTelefones(id) {
      return $http({
          url: _url + '/telefone',
          data: {
            pessoa_id: id
          },
          method: 'GET'
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getTelefones: ' + error.data);
      }
    }

    function getPessoas() {
      return $http.get(_url + '/pessoa')
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getTelefones: ' + error.data);
      }
    }

    function getAnimais(id) {
      return $http.get(_url + '/animal', {
          pessoa_id: id
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getRedesSociais: ' + error.data);
      }
    }

    function getHistorico(id) {
      return $http.get(_url + '/servicoAgendado', {
          animal_id: id
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getRedesSociais: ' + error.data);
      }
    }

    function getServicosAgendados(id) {
      return $http.get(
          _url + '/servicoAgendado', {
            pessoa_id: id
          })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getServicosAgendados: ' + error.data);
      }
    }

    function getPessoaRedesSociais(id) {
      return $http({
          url: _url + '/pessoaTemRedeSocial',
          data: {
            pessoa_id: id
          },
          method: 'GET'
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getPessoaRedesSociais: ' + error.data);
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

    function delTelefone(id) {
      return $http({
          method: 'DELETE',
          url: _url + '/telefone',
          data: {
            id: id
          }
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
