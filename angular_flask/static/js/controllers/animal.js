(function () {
   'use strict';

   angular
   .module('Animal', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/cliente/pet', {
         templateUrl: '../static/partials/pessoa/cliente/pet.html',
         controller: 'AnimalController',
         controllerAs: 'vm'
      });
   }])
   .controller('AnimalController', AnimalController)
   .factory('AnimalFactory', AnimalFactory);

   AnimalController.$inject = ['PessoaFactory', 'dataStorage', 'AnimalFactory', 'PorteFactory',
   'EspecieFactory', 'RestricaoFactory', 'RacaFactory', 'PessoaTemFuncaoFactory', 'AnimalTemRestricaoFactory',
   'TelefoneFactory', 'modalService', '$filter', 'ngToast', '$location'
]

function AnimalController(PessoaFactory, dataStorage, AnimalFactory, PorteFactory,
   EspecieFactory, RestricaoFactory, RacaFactory, PessoaTemFuncaoFactory, AnimalTemRestricaoFactory,
   TelefoneFactory, modalService, $filter, ngToast, $location) {
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
      vm.add = add;
      vm.alt = alt;
      vm.get = get;
      vm.del = del;
      vm.cancel = cancel;
      vm.set = set;
      vm.validarAnimal = validarAnimal;

      vm.form.pessoa = dataStorage.getPessoa();
      dataStorage.addPessoa(null);
      vm.form.animal = dataStorage.getAnimal();
      dataStorage.addAnimal(null);
      if (vm.form.pessoa) {
         vm.filtro = vm.form.pessoa.nome;
      }
      if (vm.form.animal) {
         vm.alterando = true;
         set(vm.form.animal);
      } else {
         vm.alterando = false;
      }

      vm.updateSelection = updateSelection;

      vm.getCliente = getCliente;
      vm.getPortes = getPortes;
      vm.getEspecies = getEspecies;
      vm.getRestricoes = getRestricoes;
      vm.getRacas = getRacas;
      vm.detalhes_animal = detalhes_animal;

      vm.addEspecie = addEspecie;
      vm.addRestricao = addRestricao;
      vm.addRaca = addRaca;
      vm.altRaca = altRaca;
      vm.delRaca = delRaca;
      vm.selectPessoa = selectPessoa;

      vm.editar_pessoa = editar_pessoa;
      vm.detalhes_pessoa = detalhes_pessoa;

      function selectPessoa() {
         if (vm.form.pessoa && vm.form.pessoa.id != null) {
            let temp = vm.form.pessoa;
            get(temp);
         }
      }

      getCliente();
      getPortes();
      getEspecies();
      getRestricoes();
      getRacas();

      function getCliente() {
         PessoaFactory.get({ cliente: true })
         .then(function (response) {
            vm.pessoas = response.data.result;
         });
      }

      function get(entry) {
         vm.animais = null;
         if (entry.checked === true) {
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
                  ngToast.danger({ content: 'Falha: ' + response.data.message });
               }
            });

            PessoaTemFuncaoFactory.get({
               pessoa_id: entry.id
            })
            .then(function (response) {
               if (response.data.success === true) {
                  if (!vm.form.animal) {
                     vm.form.animal = null;
                  }
                  vm.form.animal.pessoa_tem_funcao_cliente_id = response.data.result.id;
               } else {
                  ngToast.danger({ content: 'Falha' });
               }
            });
         }
      }

      function updateSelection(position, entities) {
         cancel();
         angular.forEach(entities, function (subscription, index) {
            if (position != subscription.id) {
               subscription.checked = false;
            }
         });
      }

      function validarAnimal() {
         vm.form.animal.data_nascimento = new Date(vm.form.animal.data_nascimento).toISOString().substring(0, 19).replace('T', ' ');
         return true;
      }

      function add() {
         if (validarAnimal()) {
            // adicionando o animal
            AnimalFactory.add(vm.form.animal)
            .then(function (response) {
               if (response.data.success === true) {
                  ngToast.success({content: 'Animal adicionado com sucesso'});
                  if (response.data.result.id) {
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

                     selectPessoa();
                  }
               } else {
                  ngToast.danger({ content: 'Falha ao adicionar registro' });
               }
            });
         }
      }

      function alt() {
         if (validarAnimal()) {

            // adicionando o animal
            AnimalFactory.alt(vm.form.animal)
            .then(function (response) {
               if (response.data.success === true) {
                  if (response.data.result.id) {

                     // deletando restricoes antigas
                     angular.forEach(vm.old_restricoes, function (value, key) {
                        AnimalTemRestricaoFactory.del(value.id).then(function (response) {});
                     });
                     var temp = {};
                     temp.animal_id = vm.form.animal.id;
                     angular.forEach(vm.form.animal.restricoes, function (value, key) {
                        temp.restricao_id = value.id;
                        AnimalTemRestricaoFactory.add(temp)
                        .then(function (response) {
                           if (response.data.success === true) {
                              ngToast.success({ content: 'Restrição alterada com sucesso' });
                           } else {
                              ngToast.danger({ content: 'Falha: ' + response.data.message });
                           }
                        });
                     });

                     selectPessoa();
                     vm.alterando = false;
                     cancel();
                  }
               } else {
                  ngToast.danger({ content: 'Falha: ' + response.data.message });
               }
            });
         }
      }

      function detalhes_animal(entry) {
         vm.form.animal = entry;
         AnimalTemRestricaoFactory.get({ animal_id: entry.id }).then(function (response) {
            if (response.data.success === true) {
               if (!angular.isArray(response.data.result)) {
                  vm.form.animal.restricoes = [];
                  vm.form.animal.restricoes.push(response.data.result);
               } else {
                  vm.form.animal.restricoes = response.data.result;
               }
            } else {
               ngToast.danger({ content: 'Falha: ' + response.data.message });
            }
         });
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
         }).then(function (response) {
            if (!angular.isArray(response.data.result)) {
               vm.form.animal.restricoes = [];
               vm.form.animal.restricoes.push(response.data.result);
            } else {
               vm.form.animal.restricoes = response.data.result;
            }
            vm.old_restricoes = vm.form.animal.restricoes;
         });
      }

      function detalhes_pessoa(entry) {
         vm.form.pessoa = {};
         vm.form.pessoa = entry;
         TelefoneFactory.get({ pessoa_id: entry.id }).then(function (response) {
            var temp = '';
            angular.forEach(response.data.result, function (value, key) {
               temp += '(' + value.codigo_area + ') ' + value.numero + '  /  '
            });
            vm.form.pessoa.telefone = temp;
         });
      }

      function editar_pessoa(entry) {
         vm.form.pessoa = entry;
         dataStorage.addPessoa(vm.form.pessoa);
         $location.path('/pessoa/cliente');
      }


      vm.openNascimento = function () {
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

      function del(data) {
         vm.form.animal = data;
         var modalOptions = {
            closeButtonText: 'Cancelar',
            actionButtonText: 'Excluir',
            actionButtonClass: 'btn btn-danger'
         };
         modalService.showModal({}, modalOptions)
         .then(function (result) {
            AnimalFactory.del(vm.form.animal.id)
            .then(function (response) {
               if (response.data.success === true) {
                  ngToast.success({ content: 'Animal excluído com sucesso' });
               } else {
                  ngToast.danger({ content: 'Falha na exclusão do registro' });
               }
            });
         });
      }

      function addRaca() {
         vm.raca.especie_id = vm.form.animal.especie_id;
         RacaFactory.add(vm.raca).then(function (response) {
            if (response.data.success === true) {
               ngToast.success({ content: 'Registro adicionado com sucesso' });
            } else {
               ngToast.danger({ content: 'Falha: ' + response.data.message });
            }
         });
      }

      function delRaca(data) {
         var modalOptions = {
            closeButtonText: 'Cancelar',
            actionButtonText: 'Excluir',
            actionButtonClass: 'btn btn-danger'
         };
         modalService.showModal({}, modalOptions)
         .then(function (result) {
            RacaFactory.del(data.id)
            .then(function (response) {
               if (response.data.success === true) {
                  ngToast.success({ content: 'Raça excluída com sucesso' });
               } else {
                  ngToast.danger({ content: 'Falha na exclusão do registro' });
               }
            });
         });
      }

      function altRaca(data) {
         RacaFactory.alt(data).then(function (response) {
            if (response.data.success === true) {
               ngToast.success({ content: 'Registro alterado com sucesso' });
            } else {
               ngToast.danger({ content: 'Falha: ' + response.data.message });
            }
         });
      }

      function addEspecie() {
         EspecieFactory.add(vm.especie).then(function (response) {}, function (response) {
            if (response.data.success === true) {
               ngToast.success({ content: 'Espécie adicionada com sucesso' });
            } else {
               ngToast.danger({ content: 'Falha: ' + response.data.message });
            }
         });
      }

      function addRestricao() {
         RetricaoFactory.add(vm.restricao).then(function (response) {
            if (response.data.success == true) {
               ngToast.success({ content: 'Restrição adicionada com sucesso' });
            } else {
               ngToast.danger({ content: 'Falha: ' + response.data.message });
            }
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
         return $http({
            url: _url + '/animal',
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
            return response;
         }
      }

      function alt(data) {
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
            return response;
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
            return response;
         }
      }
   }
})()
