(function() {
  'use strict';

  angular
    .module('Transacao', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/caixa/lancamento', {
          templateUrl: '../static/partials/caixa/lancamento.html',
          controller: 'TransacaoController',
          controllerAs: 'vm'
        })
        .when('/caixa/lista', {
          templateUrl: '../static/partials/caixa/lista.html',
          controller: 'TransacaoController',
          controllerAs: 'vm'
        });
    }])
    .controller('TransacaoController', TransacaoController)
    .factory('TransacaoFactory', TransacaoFactory);

  TransacaoController.$inject = ['TransacaoFactory', 'modalService', 'ngToast', '$filter'];

  function TransacaoController(TransacaoFactory, modalService, ngToast, $filter) {
    var vm = this;

    vm.form = {};

    vm.getHistorico = getHistorico;
    vm.alt = alt;
    vm.del = del;
    vm.add = add;

    function getHistorico() {
      vm.form.data_inicio = vm.form.data_inicio ? $filter('date')(new Date(vm.form.data_inicio), 'yyyy-MM-dd') : null;
      vm.form.data_fim = vm.form.data_fim ? $filter('date')(new Date(vm.form.data_fim), 'yyyy-MM-dd') : null;
      TransacaoFactory.getHistorico({
          data_inicio: vm.form.data_inicio,
          data_fim: vm.form.data_fim,
          tipo: vm.form.tipo
        })
        .then(function(response) {
          vm.total = response.data.result.caixa;
          vm.historico = response.data.result.historico;
          vm.soma_credito = response.data.result.soma_credito;
          vm.soma_debito = response.data.result.soma_debito;
          angular.forEach(vm.historico, function(value, key) {
            value.data_hora = $filter('date')(new Date(value.data_hora), 'dd/MM/yyyy');
          });
        }, function(response) {
          ngToast.warning({
            content: '<b>Falha ao buscar registros</b>: ' + response.data.message
          });
        });
    }

    function add() {
      TransacaoFactory.add(vm.form)
        .then(function(response) {
          console.log("response", response);
          if (response.data.success != true) {
            ngToast.warning({
              content: '<b>Falha ao adicionar o registro</b>: ' + response.data.message
            });
          } else {
            ngToast.success({
              content: 'Registro adicionado com sucesso'
            });
          }
        }, function(response) {
          ngToast.warning({
            content: '<b>Falha ao incluir o registro</b>: ' + response.data.message
          });
        });
    }

    function alt(data) {
      TransacaoFactory.alt(data)
        .then(function(response) {
          getHistorico();
          if (response.data.success != true) {
            ngToast.warning({
              content: '<b>Falha ao alterar o registro</b>: ' + response.data.message
            });
          } else {
            ngToast.success({
              content: 'Registro alterado com sucesso'
            });
          }
        }, function(response) {
          ngToast.warning({
            content: '<b>Falha ao alterar o registro</b>: ' + response.data.message
          });
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
          TransacaoFactory.del(entry.id)
            .then(function(response) {
              if (response.data.success != true) {
                ngToast.warning({
                  content: '<b>Falha ao excluir o registro</b>: ' + response.data.message
                });
              } else {
                ngToast.success({
                  content: 'Registro excluído com sucesso'
                });
              }
              getHistorico();
            }, function(response) {
              ngToast.warning({
                content: '<b>Falha ao excluir o registro</b>: ' + response.data.message
              });
            });
        });
    }

    vm.openDataInicio = function() {
      vm.popupDataInicio = true;
    }
    vm.openDataFim = function() {
      vm.popupDataFim = true;
    }

    vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
    vm.format = vm.formats[0];
    vm.altInputFormats = ['d!/M!/yyyy'];

    vm.popupDataInicio = false;
    vm.popupDataFim = false;
    vm.setDate = setDate;

    function setDate(value, year, month, day) {
      value = new Date(year, month, day);
    }
  }

  TransacaoFactory.$inject = ['$http', 'Fluffy'];

  function TransacaoFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var TransacaoFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del,
      getHistorico: getHistorico
    };
    return TransacaoFactory;

    function get(data) {
      data = data || null;
      return $http({
          url: _url + '/transacao',
          params: data,
          method: 'GET'
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

    function getHistorico(data) {
      console.log("historico", JSON.stringify(data));
      data = data || null;
      return $http({
          url: _url + '/getHistorico',
          params: data,
          method: 'GET'
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

    function add(data) {
      console.log('SAVING: ' + JSON.stringify(data));
      return $http({
          method: 'POST',
          url: _url + '/transacao',
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
              method: 'PUT',
              url: _url + '/transacao',
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
              method: 'DELETE',
              url: _url + '/transacao',
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
