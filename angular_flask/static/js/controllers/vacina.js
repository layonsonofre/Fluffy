(function() {
  'use strict';

  angular
    .module('Vacina', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/estoque/vacina', {
          templateUrl: '../static/partials/estoque/vacina.html',
          controller: 'VacinaController',
          controllerAs: 'vm'
        })
    }])
    .controller('VacinaController', VacinaController)
    .factory('VacinaFactory', VacinaFactory);

  VacinaController.$inject = ['VacinaFactory', 'modalService'];

  function VacinaController(VacinaFactory, modalService) {
    var vm = this;
    vm.form = null;

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    get();

    function get() {
      VacinaFactory.get()
        .then(function(response) {
          vm.grupos = response.data.result;
        }, function(response) {
          vm.status = response.message
        });
    }

    function add() {
      VacinaFactory.add(vm.form)
        .then(function(response) {
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function alt(data) {
      VacinaFactory.alt(data)
        .then(function(response) {
          get();
        }, function(response) {
          vm.status = response.message
        });
    }

    function del(entry) {
      var modalOptions = {
        closeButtonText: 'Cancelar',
        actionButtonText: 'Excluir',
        actionButtonClass: 'btn btn-danger'
      };
      modalService.showModal({}, modalOptions)
        .then(function(result) {
          VacinaFactory.del(entry.id)
            .then(function(response) {
              get();
            }, function(response) {
              vm.status = response.message
            });
        });
    }
  }

  VacinaFactory.$inject = ['$http', 'Fluffy'];

  function VacinaFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var VacinaFactory = {
      getRedesSociais: getRedesSociais,
      getTelefones: getTelefones,
      getVacinas: getVacinas,
      getAnimais: getAnimais,
      getHistorico: getHistorico,
      getServicosAgendados: getServicosAgendados,
      add: add,
      delTelefone: delTelefone,
      del: del,
      getPessoaRedesSociais: getPessoaRedesSociais
    };
    return VacinaFactory;

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

    function getVacinas() {
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
