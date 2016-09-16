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

    vm.telefones = [{
      id: 'telefone1'
    }];
    vm.socials = [];

    vm.clientes = [{
      id: 0,
      nome: 'André Cadamuro Garcia',
      email: 'andrecadgarcia@gmail.com',
      telefone: '+55 14 997033167',
      endereco: 'Av. Cel. Albino Alves Garcia, 970 - Centro - Bernardino de Campos - SP'
    }, {
      id: 1,
      nome: 'Aurélio Hiroshi Osawa',
      email: 'konichiwa@gmail.com',
      telefone: '+55 42 99765123',
      endereco: 'Rua Com. Paulo Pinheiro Schimidt, 344 - Uvaranas - Ponta Grossa - PR'
    }, {
      id: 2,
      nome: 'Cesar Augusto dos Santos',
      email: 'cesinha_corinthians@gmail.com',
      telefone: '+55 42 98817431',
      endereco: 'Rua Papa Pio, 9997 - Jardim Bom Sucesso - Ponta Grossa - PR	'
    }];

    // ClienteFactory.getRedesSociais()
    //   .then(function(response) {
    //     vm.tipoRedeSocial = response.data;
    //   }, function(response) {
    //     vm.status = 'Failed to load socials networks: ' + error.message;
    //   });

    ClienteFactory.getTelefones()
      .then(function(response) {
        vm.telefones = response.data;
      }, function(response) {
        vm.status = 'Failed to load telefones: ' + error.message;
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

    function addTelefone() {
      var newItemNo = vm.telefones.length + 1;
      vm.telefones.push({
        'id': 'telefone' + newItemNo
      });
    }

    function removeTelefone() {
      var lastItem = vm.telefones.length - 1;
      vm.telefones.splice(lastItem);
    }

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
    var urlBase = _url + '/cliente/cadastro';
    var ClienteFactory = {
      getRedesSociais: getRedesSociais,
      getTelefones: getTelefones
    };
    return ClienteFactory;

    function getRedesSociais() {
      return $http.get(_url + '/tipoRedeSocial')
        .then(getRedesSociaisComplete)
        .catch(getRedesSociaisFailed);

      function getRedesSociaisComplete(response) {
        return response.data.results;
      }

      function getRedesSociaisFailed(error) {
        console.error('Failed getRedesSociais: ' + error.data);
      }
    }


    function getTelefones() {
      return $http.get(_url + '/telefone')
        .then(getTelefonesComplete)
        .catch(getTelefonesFailed);

      function getTelefonesComplete(response) {
        return response.data.results;
      }

      function getTelefonesFailed(error) {
        console.error('Failed getTelefones: ' + error.data);
      }
    }
  }

})()
