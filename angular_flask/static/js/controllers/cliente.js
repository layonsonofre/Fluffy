(function() {
   'use strict';

   angular
      .module('Cliente', [])
      .config(['$routeProvider', function($routeProvider) {
         $routeProvider
            .when('/cliente/cadastro', {
               templateUrl: '../static/partials/cliente/cadastro.html',
               controller: 'ClienteController',
               controllerAs: 'Cliente'
            })
            .when('/cliente/pet', {
               templateUrl: '../static/partials/cliente/pet.html',
               controller: 'ClienteController',
               controllerAs: 'Cliente'
            })
            .when('/cliente/busca', {
               templateUrl: '../static/partials/cliente/busca.html',
               controller: 'ClienteController',
               controllerAs: 'Cliente'
            })
      }])
      .controller('ClienteController', ClienteController)
      .factory('ClienteFactory', ClienteFactory);

   ClienteController.$inject = ['$scope', '$http', 'ClienteFactory'];

   function ClienteController($scope, $http, ClienteFactory) {
      var vm = this;

      vm.getAnimais = getAnimais;

      ClienteFactory.getRedesSociais()
         .then(function(response) {
            vm.tipoRedeSocial = response.data;
         }, function(response) {
            vm.status = 'Failed to load socials networks: ' + error.message;
         });

      ClienteFactory.getTelefones(vm.pessoa_id)
         .then(function(response) {
            vm.telefones = response;
         }, function(response) {
            vm.status = 'Failed to load telefones: ' + error.message;
         });

      ClienteFactory.getClientes()
         .then(function(response) {
            vm.clientes = response;
         }, function(response) {
            vm.status = 'Failed to load clientes: ' + error.message;
         });

      function getAnimais(id) {
         if (vm.cliente[id]) {
            alert(id);
            ClienteFactory.getAnimais(id)
               .then(function(response) {
                  vm.animais = response;
               }, function(response) {
                  vm.status = 'Failed to load clientes: ' + error.message;
               });
         }
      }

      ClienteFactory.getServicosContratados()
         .then(function(response) {
            vm.servicos = response;
         }, function(response) {
            vm.status = 'Failed to load clientes: ' + error.message;
         });

      vm.adicionarAnimal = false;
      vm.pais = "Brasil";
      vm.estado = "PR";
      vm.cidade = "Ponta Grossa";
      vm.addTelefone = addTelefone;
      vm.removeTelefone = removeTelefone;
      vm.showAdicionarAnimal = showAdicionarAnimal;
      vm.addSocial = addSocial;
      vm.removeSocial = removeSocial;
      vm.search_zip_code = search_zip_code;

      function showAdicionarAnimal() {
         vm.adicionarAnimal = (vm.adicionarAnimal == true) ? false : true;
      }

      function addSocial() {
         var newSocialNo = vm.socials.length + 1;
         vm.socials.push({
            'id': 'social' + newSocialNo
         });
      }

      function removeSocial() {
         var lastSocial = vm.socials.length - 1;
         vm.socials.splice(lastSocial);
      }

      function search_zip_code() {
         $http.get("http://cep.republicavirtual.com.br/web_cep.php?cep=" + vm.cep + "&formato=json")
            .then(function(response) {
               vm.pais = "Brasil";
               vm.estado = response.data["uf"];
               vm.cidade = response.data["cidade"];
               vm.rua = response.data["tipo_logradouro"] + " " + response.data["logradouro"];
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
         getServicosContratados: getServicosContratados
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
            console.log('CLIENTES: ' + response.data.result);
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
            console.log('ANIMAIS: ' + response.data.result);
            return response.data.result.result;
         }

         function failed(error) {
            console.error('Failed getRedesSociais: ' + error.data);
         }
      }

      function getServicosContratados(id) {
         return $http.get(_url + '/servicoAgendado', {
               animal_id: id
            })
            .then(success)
            .catch(failed);

         function success(response) {
            console.log(response.data.result);
            return response.data.result.result;
         }

         function failed(error) {
            console.error('Failed getRedesSociais: ' + error.data);
         }
      }

   }

})()
