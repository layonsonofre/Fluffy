(function() {
  'use strict';

  angular
    .module('Lembrete', [])
    .controller('LembreteController', LembreteController)
    .factory('LembreteFactory', LembreteFactory);

  LembreteController.$inject = ['LembreteFactory', 'modalService'];

  function LembreteController(LembreteFactory, modalService) {
    var vm = this;

    vm.form = {};
    vm.form.visualizado = false;
    vm.form.pessoa_id = 3;

    vm.get = get;
    vm.add = add;
    vm.alt = alt;
    vm.del = del;

    get();

    function get() {
      LembreteFactory.get()
        .then(function(response) {
          vm.lembretes = response.data.result;
        }, function(response) {
          console.error(response);
        });
    }

    function add() {
      LembreteFactory.add(vm.form)
        .then(function(response) {
          get();
        }, function(response) {
          console.error(response)
        });
    }

    function alt(data) {
      LembreteFactory.alt(data)
        .then(function(response) {
          get();
        }, function(response) {
          console.error(response)
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
          LembreteFactory.del(entry.id)
            .then(function(response) {
              get();
            }, function(response) {
              vm.status = response.message
            });
        });
    }

    vm.openData = function() {
      vm.popupData = true;
    }

    vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
    vm.format = vm.formats[0];
    vm.altInputFormats = ['d!/M!/yyyy'];

    vm.popupData = false;
    vm.setDate = setDate;

    function setDate(year, month, day) {
      vm.form.data_hora = new Date(year, month, day);
    }
  }

  LembreteFactory.$inject = ['$http', 'Fluffy'];

  function LembreteFactory($http, Fluffy) {
    var _url = Fluffy.urlBase;
    var LembreteFactory = {
      get: get,
      add: add,
      alt: alt,
      del: del
    };
    return LembreteFactory;

    function get() {
      return $http.get(
          _url + '/lembrete'
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

    function add(data) {
      console.log('SAVING: ' + JSON.stringify(data));
      return $http({
          method: 'POST',
          url: _url + '/lembrete',
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
          url: _url + '/lembrete',
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
          url: _url + '/lembrete',
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
