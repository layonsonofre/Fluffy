(function() {
  'use strict';

  angular
    .module('Cliente', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/cliente/cadastro', {
          templateUrl: '../static/partials/cliente/cadastro.html',
          controller: 'ClienteController',
          controllerAs: 'vm'
        })
        .when('/cliente/pet', {
          templateUrl: '../static/partials/cliente/pet.html',
          controller: 'ClienteController',
          controllerAs: 'vm'
        })
        .when('/cliente/busca', {
          templateUrl: '../static/partials/cliente/busca.html',
          controller: 'ClienteController',
          controllerAs: 'vm'
        })
    }])
    .controller('ClienteController', ClienteController)
    .factory('ClienteFactory', ClienteFactory);

  ClienteController.$inject = ['ClienteFactory', '$http', 'RedeSocialFactory', 'ServicoFactory', 'PorteFactory', 'RacaFactory', 'EspecieFactory', 'RestricaoFactory', 'modalService', 'dataStorage', '$location', 'calendarConfig'];

  function ClienteController(ClienteFactory, $http, RedeSocialFactory, ServicoFactory, PorteFactory, RacaFactory, EspecieFactory, RestricaoFactory, modalService, dataStorage, $location, calendarConfig) {
    var vm = this;

    vm.form = dataStorage.getPessoa();

    vm.add = add;
    vm.alt = alt;
    vm.excluir_cliente = excluir_cliente;
    vm.gotoAddPet = gotoAddPet;

    vm.removeTelefone = removeTelefone;
    vm.incluirTelefone = incluirTelefone;
    vm.getTelefones = getTelefones;

    vm.helpActive = false;
    vm.getPessoaRedesSociais = getPessoaRedesSociais;
    vm.getTiposRedesSociais = getTiposRedesSociais;
    vm.incluirPessoaRedeSocial = incluirPessoaRedeSocial;
    vm.addRedeSocial = addRedeSocial;

    vm.getClientes = getClientes;
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
    vm.form.pais = "Brasil";
    vm.form.estado = "PR";
    vm.form.cidade = "Ponta Grossa";
    vm.showAdicionarTelefone = false;
    vm.showAdicionarAnimal = showAdicionarAnimal;
    vm.search_zip_code = search_zip_code;

    getTiposRedesSociais();
    getClientes();
    vm.status = null;
    vm.filtro = vm.form.nome;

    function setPage(page) {
      vm.currentPage = page;
    }

    getPortes();
    getEspecies();
    getRestricoes();
    getRacas();

    function incluirTelefone() {
      getTelefones(true);
    }

    function removeTelefone(item) {
      if (id === null) {
        vm.form.telefones = vm.form.telefones.splice(vm.form.telefones.indexOf(item), 1)
      } else {
        ClienteFactory.delTelefone(id)
          .then(function(response) {
            alert("MISSING BACKEND CALL");
          }, function(response) {
            vm.status = 'Falha na tentativa de remover o telefone.\n' + error.message;
          });
      }
    }

    function getTelefones(append) {
      ClienteFactory.getTelefones(vm.form.pessoa_id)
        .then(function(response) {
          vm.form.telefones = response;
          if (append) {
            vm.form.telefones.push({});
          }
        }, function(response) {
          vm.status = 'Failed to load telefones: ' + error.message;
        });
    }

    function incluirPessoaRedeSocial() {
      getPessoaRedesSociais(true);
    }

    function getPessoaRedesSociais(append) {
      ClienteFactory.getPessoaRedesSociais()
        .then(function(response) {
          vm.form.redesSociais = response;
          if (append) {
            vm.form.redesSociais.push({});
          }
        }, function(response) {
          vm.status = 'Failed to load socials networks: ' + error.message;
        });
    }

    function removeRedeSocial(item) {
      if (id === null) {
        vm.form.redesSociais = vm.form.redesSociais.splice(vm.form.redesSociais.indexOf(item), 1)
      } else {
        ClienteFactory.delPessoaSocial(id)
          .then(function(response) {
            alert("MISSING BACKEND CALL");
          }, function(response) {
            vm.status = 'Falha na tentativa de remover a rede social.\n' + error.message;
          });
      }
    }

    function getTiposRedesSociais() {
      RedeSocialFactory.get()
        .then(function(response) {
          vm.form.tiposRedesSociais = response;
          console.log(vm.form.tiposRedesSociais);
        }, function(response) {
          vm.status = 'Failed to load socials networks: ' + error.message;
        });
    }

    function addRedeSocial() {
      RedeSocial.add(vm.form.redeSocial)
        .then(function(response) {
          console.log(response);
        }, function(response) {
          vm.status = 'Failed ' + error.message;
        })
    }

    function getClientes() {
      ClienteFactory.getClientes()
        .then(function(response) {
          vm.clientes = response;
        }, function(response) {
          vm.status = 'Failed to load clientes: ' + error.message;
        });
    }

    function getAnimais(entry) {
      vm.animais = {};
      if (entry.checked) {
        ClienteFactory.getAnimais(entry.id)
          .then(function(response) {
            vm.animais = response;
          }, function(response) {
            vm.status = 'Failed to load clientes: ' + error.message;
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
        ServicoFactory.getServicosAgendados(entry.id)
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
      $http.get("http://cep.republicavirtual.com.br/web_cep.php?cep=" + vm.form.cep + "&formato=json")
        .then(function(response) {
          console.log(response);
          vm.form.pais = "Brasil";
          vm.form.estado = response.data["uf"];
          vm.form.cidade = response.data["cidade"];
          vm.form.rua = response.data["tipo_logradouro"] + " " + response.data["logradouro"];
        });
    }


    function add() {
      console.log("SAVING: " + JSON.stringify(vm.form));
      ClienteFactory.add(vm.form)
        .then(function(response) {
          console.log(response);
        }, function(response) {
          console.error(response)
        });
    }

    function alt() {
      alert('alt');
    }

    function excluir_cliente(data) {
      vm.form = data;
      var modalOptions = {
        closeButtonText: 'Cancelar',
        actionButtonText: 'Excluir',
        actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
        .then(function(result) {
          ClienteFactory.del(vm.form.id)
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
      dataStorage.addPessoa(vm.form);
      $location.path('/cliente/pet');
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
          console.log(vm.portes);
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    function getRacas() {
      RacaFactory.get()
        .then(function(response) {
          vm.racas = response;
          console.log(vm.racas);
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    function getEspecies() {
      EspecieFactory.get()
        .then(function(response) {
          vm.especies = response;
          console.log(vm.especies);
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }

    function getRestricoes() {
      RestricaoFactory.get()
        .then(function(response) {
          vm.restricoes = response;
          console.log(vm.restricoes);
        }, function(response) {
          vm.status = 'Failed to load: ' + error.message;
        });
    }
  }

  ClienteFactory.$inject = ['$http', 'Fluffy'];

  function ClienteFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var ClienteFactory = {
      getRedesSociais: getRedesSociais,
      getTelefones: getTelefones,
      getClientes: getClientes,
      getAnimais: getAnimais,
      getHistorico: getHistorico,
      getServicosAgendados: getServicosAgendados,
      add: add,
      delTelefone: delTelefone,
      del: del,
      getPessoaRedesSociais: getPessoaRedesSociais
    };
    return ClienteFactory;

    function getRedesSociais() {
      return $http.get(_url + '/redeSocial')
        .then(success)
        .catch(failed);

      function success(response) {
        console.log(response.data);
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getRedesSociais: ' + error.data);
      }
    }

    function getTelefones(id) {
      return $http.get(_url + '/telefone', {
          pessoa_id: id
        })
        .then(success)
        .catch(failed);

      function success(response) {
        console.log(response.data.result);
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getTelefones: ' + error.data);
      }
    }

    function getClientes() {
      return $http.get(_url + '/pessoa')
        .then(success)
        .catch(failed);

      function success(response) {
        console.log(response.data.result);
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
        console.log(response.data.result);
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
        console.log(response.data.result);
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
        console.log('SERVICOS: ' + response.data.result);
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getServicosAgendados: ' + error.data);
      }
    }

    function getPessoaRedesSociais(id) {
      return $http.get(
          _url + '/pessoaTemRedeSocial', {
            pessoa_id: id
          })
        .then(success)
        .catch(failed);

      function success(response) {
        console.log(response.data.result);
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed getPessoaRedesSociais: ' + error.data);
      }
    }


    function add(data) {
      console.log('SAVING: ' + JSON.stringify(data));
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
      return $http.delete(
          _url + '/cliente',
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

    function delTelefone(id) {
      console.log(JSON.stringify(id));
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
        console.log(response);
        return response;
      }

      function failed(response) {
        console.error('Failed: ' + JSON.stringify(response));
      }
    }

  }

})()
