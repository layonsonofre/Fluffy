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

  ClienteController.$inject = ['$scope', '$http', 'ClienteFactory'];

  function ClienteController($scope, $http, ClienteFactory) {
    var vm = this;

    vm.form = {};

    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    vm.helpActive = false;

    vm.getAnimais = getAnimais;

    ClienteFactory.getRedesSociais()
      .then(function(response) {
        vm.redesSociais = response;
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

    ClienteFactory.getServicosContratados(id)
      .then(function(response) {
        vm.servicos = response;
      }, function(response) {
        vm.status = 'Failed to load clientes: ' + error.message;
      });

    vm.adicionarAnimal = false;
    vm.form.pais = "Brasil";
    vm.form.estado = "PR";
    vm.form.cidade = "Ponta Grossa";
    vm.showAdicionarAnimal = showAdicionarAnimal;
    vm.search_zip_code = search_zip_code;

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

    function del() {
      alert('del');
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
      getServicosAgendados: getServicosAgendados,
      add: add
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
        console.error('Failed getRedesSociais: ' + error.data);
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

  }

})()
