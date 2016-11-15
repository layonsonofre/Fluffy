(function() {
  'use strict';

  angular
    .module('Animal', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/pessoa/pet', {
          templateUrl: '../static/partials/pessoa/pet.html',
          controller: 'AnimalController',
          controllerAs: 'vm'
        });
    }])
    .controller('AnimalController', AnimalController)
    .factory('AnimalFactory', AnimalFactory);

  AnimalController.$inject = ['PessoaFactory', 'dataStorage', 'AnimalFactory', 'PorteFactory',
    'EspecieFactory', 'RestricaoFactory', 'RacaFactory', 'PessoaTemFuncaoFactory', 'AnimalTemRestricaoFactory',
    'TelefoneFactory', 'modalService', '$filter'
  ]

  function AnimalController(PessoaFactory, dataStorage, AnimalFactory, PorteFactory,
    EspecieFactory, RestricaoFactory, RacaFactory, PessoaTemFuncaoFactory, AnimalTemRestricaoFactory,
    TelefoneFactory, modalService, $filter) {
    var vm = this;
    vm.form = {};
    vm.form.pessoa = dataStorage.getPessoa();
    vm.form.animal = dataStorage.getAnimal();
    vm.filtro = vm.form.pessoa.nome;
    vm.alterando = false;

    vm.add = add;
    vm.alt = alt;
    vm.get = get;
    vm.del = del;
    vm.cancel = cancel;
    vm.set = set;
    vm.validarAnimal = validarAnimal;
    vm.handleResponse = handleResponse;

    vm.updateSelection = updateSelection;

    vm.getPessoas = getPessoas;
    vm.getPortes = getPortes;
    vm.getEspecies = getEspecies;
    vm.getRestricoes = getRestricoes;
    vm.getRacas = getRacas;

    vm.addEspecie = addEspecie;
    vm.addRestricao = addRestricao;
    vm.addRaca = addRaca;
    vm.selectPessoa = selectPessoa;

    vm.editar_pessoa = editar_pessoa;
    vm.detalhes_pessoa = detalhes_pessoa;

    function selectPessoa() {
      console.log('pessoa:', vm.form.pessoa);
      if (vm.form.pessoa.id != null) {
        let temp = vm.form.pessoa;
        // temp.checked = true;
        get(temp);
      }
    }

    getPessoas();
    getPortes();
    getEspecies();
    getRestricoes();
    getRacas();

    function getPessoas() {
      PessoaFactory.get()
        .then(function(response) {
          vm.pessoas = response;
          console.log(response);
        }, function(response) {
          vm.status = 'Failed to load: ' + response.message;
        });
    }

    function get(entry) {
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

        PessoaTemFuncaoFactory.get({
            pessoa_id: entry.id
          })
          .then(function(response) {
            console.log('pessoa funcao', response);
            if (!vm.form.animal) {
              vm.form.animal = {};
            }
            vm.form.animal.pessoa_tem_funcao_cliente_id = response.id;
          }, function(response) {
            console.log('pessoa funcao erro', response);
          });
      }
    }

    function updateSelection(position, entities) {
      cancel();
      angular.forEach(entities, function(subscription, index) {
        if (position != subscription.id) {
          subscription.checked = false;
        }
      });
    }

    function handleResponse(response) {
      console.log(response);
    }

    function validarAnimal() {
      vm.form.animal.data_nascimento = new Date(vm.form.animal.data_nascimento).toISOString().substring(0, 19).replace('T', ' ');
      return true;
    }

    function add() {
      if (validarAnimal()) {
        // adicionando o animal
        AnimalFactory.add(vm.form.animal)
          .then(function(response) {
            console.log(response);
            if (response.data.result.id) {
              console.log('animal cadastrada');
              vm.status = 'animal cadastrada com sucesso';
              vm.form.animal.id = response.data.result.id;

              // adicionando restricoes
              var temp = {};
              temp.animal_id = vm.form.animal.id;
              angular.forEach(vm.form.animal.restricoes, function(value, key) {
                temp.restricao_id = value;

                AnimalTemRestricaoFactory.add(value)
                  .then(function(response) {
                    vm.status = 'Restrição cadastrado com sucesso';
                  }, function(response) {
                    handleResponse(response)
                  });
              });

              selectPessoa();
            }
          }, function(response) {
            console.log('erro animal');
            handleResponse(response);
          });
      }
    }

    function alt() {
      if (validarAnimal()) {

        // adicionando o animal
        AnimalFactory.alt(vm.form.animal)
          .then(function(response) {
            console.log(response);
            if (response.data.result.id) {
              console.log('animal alterado');
              vm.status = 'animal alterado com sucesso';

              // adicionando restricoes
              var temp = {};
              temp.animal_id = vm.form.animal.id;
              angular.forEach(vm.form.animal.restricoes, function(value, key) {
                temp.restricao_id = value;

                AnimalTemRestricaoFactory.alt(value)
                  .then(function(response) {
                    vm.status = 'Restrição alterada com sucesso';
                  }, function(response) {
                    handleResponse(response)
                  });
              });

              selectPessoa();
              vm.alterando = false;
            }
          }, function(response) {
            console.log('erro animal');
            handleResponse(response);
          });
      }
    }

    function set(entry) {
      vm.alterando = true;
      vm.form.animal = {};
      vm.form.animal.id = entry.id;
      vm.form.animal.nome = entry.nome;
      vm.form.animal.data_nascimento = Date.parse(entry.data_nascimento);
      vm.form.animal.sexo = entry.sexo;
      vm.form.animal.porte_id = entry.porte.id;
      vm.form.animal.raca_id = entry.raca.id;

      AnimalTemRestricaoFactory.get({
        animal_id: entry.id
      }).then(function(response) {
        console.log('restricoes', response);
        vm.form.animal.restricoes = [];
        angular.forEach(response.restricao, function(value, key) {
          vm.form.animal.restricoes.push(value);
        })
      });
      console.log('animal', vm.form.animal);
    }

    function detalhes_pessoa(entry) {
      vm.form.pessoa = {};
      vm.form.pessoa = entry;
      TelefoneFactory.get({pessoa_id: entry.id}).then(function(response) {
        console.log(response);
        var temp = '';
        angular.forEach(response, function(value, key) {
          temp += '(' + value.codigo_area + ') '+ value.numero + '  /  '
        });
        vm.form.pessoa.telefone = temp;
      });
      console.log('animal', vm.form.pessoa);
    }

    function editar_pessoa(entry) {
      vm.form.pessoa = entry;
      dataStorage.addPessoa(vm.form.pessoa);
      $location.path('/pessoa/cliente');
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
      let filtro = '';
      if (vm.form.animal) {
        filtro = vm.form.animal.especie_id;
        RacaFactory.get({
            especie_id: filtro
          })
          .then(function(response) {
            vm.racas = response;
            console.log('racas', vm.racas);
          }, function(response) {
            vm.status = 'Failed to load: ' + error.message;
          });
      }
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

    function del(data) {
      vm.form.animal = data;
      var modalOptions = {
        closeButtonText: 'Cancelar',
        actionButtonText: 'Excluir',
        actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
        .then(function(result) {
          AnimalFactory.del(vm.form.animal.id)
            .then(function(response) {
              console.log(response);
            }, function(response) {
              console.error(response);
            });
        });
    }

    function addRaca() {
      RacaFactory.add(vm.raca).then(function(response) {
        console.log(response)
      }, function(response) {
        console.log(response)
      });
    }

    function addEspecie() {
      EspecieFactory.add(vm.especie).then(function(response) {
        console.log(response)
      }, function(response) {
        console.log(response)
      });
    }

    function addRestricao() {
      RetricaoFactory.add(vm.restricao).then(function(response) {
        console.log(response)
      }, function(response) {
        console.log(response)
      });
    }

    function cancel() {
      vm.form.animal = {};
      vm.alterando = false;
    }
  }

  AnimalFactory.$inject = ['$http', 'Fluffy'];

  function AnimalFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var AnimalFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return AnimalFactory;

    function get(data) {
      data = data || null;
      console.log('params', data);
      return $http({
          url: _url + '/animal',
          method: 'GET',
          params: data
        })
        .then(success)
        .catch(failed);

      function success(response) {
        return response.data.result;
      }

      function failed(error) {
        console.error('Failed: ' + error.data);
      }
    }

    function add(data) {
      console.log('add', JSON.stringify(data));
      return $http({
          url: _url + '/animal',
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
      console.log('UPDATING: ' + JSON.stringify(data));
      return $http({
          url: _url + '/animal',
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
          url: _url + '/animal',
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
