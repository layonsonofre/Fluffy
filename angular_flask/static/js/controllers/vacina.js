(function () {
   'use strict';

   angular
   .module('Vacina', [])
   .config(['$routeProvider', function ($routeProvider) {
      $routeProvider
      .when('/estoque/vacina', {
         templateUrl: '../static/partials/estoque/vacina.html',
         controller: 'VacinaController',
         controllerAs: 'vm'
      })
   }])
   .controller('VacinaController', VacinaController)
   .factory('VacinaFactory', VacinaFactory);

   VacinaController.$inject = ['VacinaFactory', 'LoteFactory', 'VacinaTemLoteFactory', 'modalService', 'calendarConfig', 'ngToast', '$location', 'dataStorage'];

   function VacinaController(VacinaFactory, LoteFactory, VacinaTemLoteFactory, modalService, calendarConfig, ngToast, $location, dataStorage) {
      var vm = this;

      if (dataStorage.getUser() == null) {
         $location.path('/login');
         ngToast.danger({content: 'Necessário realizar o login antes de utilizar esta funcionalidade'});
      }

      if (!dataStorage.checkPermission('Consulta')) {
         $location.path('/erro');
         ngToast.danger({content: 'Você não tem permissão para acessar esta funcionalidade'});
      }
      vm.form = {};

      vm.get = get;
      vm.add = add;
      vm.alt = alt;
      vm.del = del;

      vm.getLote = getLote;
      vm.addLote = addLote;
      vm.delLote = delLote;
      vm.setLote = setLote;
      vm.cancelLote = cancelLote;

      vm.updateSelection = updateSelection;

      get();

      function get() {
         VacinaFactory.get()
         .then(function (response) {
            vm.vacinas = response.data.result;
         });
      }

      function add() {
         VacinaFactory.add(vm.form.vacina)
         .then(function (response) {
            if (response.data.success != true) {
               ngToast.danger({
                  content: '<b>Falha ao adicionar o registro</b>: ' + response.data.message
               });
            } else {
               get();
               ngToast.success({
                  content: 'Registro adicionado com sucesso'
               });
            }
         });
      }

      function alt(data) {
         VacinaFactory.alt(data)
         .then(function (response) {
            if (response.data.success != true) {
               ngToast.danger({
                  content: '<b>Falha ao alterar o registro</b>: ' + response.data.message
               });
            } else {
               get();
               ngToast.success({
                  content: 'Registro alterado com sucesso'
               });
            }
         });
      }

      function del(entry) {
         var modalOptions = {
            closeButtonText: 'Cancelar',
            actionButtonText: 'Excluir',
            actionButtonClass: 'btn btn-danger'
         };
         modalService.showModal({}, modalOptions)
         .then(function (result) {
            VacinaFactory.del(entry.id)
            .then(function (response) {
               if (response.data.success != true) {
                  ngToast.danger({
                     content: '<b>Falha ao excluir o registro</b>: ' + response.data.message
                  });
               } else {
                  get();
                  ngToast.success({
                     content: 'Registro excluído com sucesso'
                  });
               }
            });
         });
      }

      function setLote(entry) {
         vm.lote = entry.lote;
         vm.alterandoLote = true;
      }


      function addLote() {
         vm.lote.vencimento = new Date(vm.lote.vencimento).toISOString().substring(0, 19).replace('T', ' ');
         if (vm.alterandoLote) {
            vm.alterandoLote = false;
            LoteFactory.alt(vm.lote)
            .then(function (response) {
               if (response.data.success != true) {
                  ngToast.danger({content: '<b>Falha ao alterar o lote</b>: ' + response.data.message});
               } else {
                  ngToast.success({content: 'Lote alterado com sucesso'});

                  VacinaTemLoteFactory.alt({id: vm.lote.vacina_tem_lote_id, quantidade: vm.lote.quantidade}).then(function(response) {
                     if (response.data.success === true) {
                        getLote(vm.vacina);
                        ngToast.success({content: 'Quantidade de vacina do lote alterada com sucesso'});
                     } else {
                        ngToast.danger({content: '<b>Falha ao alterar o registro</b>: ' + response.data.message});
                     }
                  });

               }
            });
         } else {
            LoteFactory.add(vm.lote)
            .then(function (response) {
               if (response.data.success != true) {
                  ngToast.danger({ content: '<b>Falha ao adicionar o registro</b>: ' + response.data.message });
               } else {
                  ngToast.success({
                     content: 'Registro adicionado com sucesso'
                  });
                  var lote_id = response.data.result.id;
                  VacinaTemLoteFactory.add({
                     lote_id: lote_id,
                     vacina_id: vm.vacina.id,
                     quantidade: vm.lote.quantidade
                  }).then(function (response) {
                     if (response.data.success === true) {
                        ngToast.success({ content: 'O lote foi vinculado à vacina' });
                        getLote(vm.vacina);
                     } else {
                        ngToast.danger({ content: 'Lote não vinculado à vacina' });
                     }
                  });
               }
            });
         }
      }

      function delLote(entry) {
         if (entry.id === null) {
            vm.form.lotes = vm.form.lotes.splice(vm.form.lotes.indexOf(entry), 1)
         } else {
            var modalOptions = {
               closeButtonText: 'Cancelar',
               actionButtonText: 'Excluir',
               actionButtonClass: 'btn btn-danger'
            };
            modalService.showModal({}, modalOptions)
            .then(function (result) {
               VacinaTemLoteFactory.get({ lote_id: entry.id }).then(function (response) {
                  console.log("response", response);
                  if (response.data.success === true) {
                     VacinaTemLoteFactory.del({ id: response.data.result.id }).then(function (response) {
                        console.log("response2", response);
                        if (response.data.result === true) {
                           ngToast.success({ content: 'Vínculo removido com sucesso' });

                           LoteFactory.del(entry.id)
                           .then(function (response) {
                              if (response.data.success != true) {
                                 ngToast.danger({ content: '<b>Falha ao excluir o registro</b>: ' + response.data.message });
                              } else {
                                 ngToast.success({ content: 'Registro excluído com sucesso' });
                                 getLote(vm.vacina);
                              }
                           });
                        } else {
                           ngToast.danger({ content: '<b>Falha ao excluir vínculo da vacina com o lote</b>: ' + response.data.message });
                        }
                     })
                  } else {
                     ngToast.danger({ content: '<b>Não encontrado vínculo da vacina com o lote</b>: ' + response.data.message });
                  }
               });
            });
         }
      }

      function getLote(entry) {
         vm.form.lotes = [];
         if (entry.checked === true) {
            VacinaTemLoteFactory.get({
               vacina_id: entry.id
            })
            .then(function (response) {
               if (!angular.isArray(response.data.result)) {
                  vm.form.lotes = [];
                  vm.form.lotes.push(response.data.result);
               } else {
                  vm.form.lotes = response.data.result;
               }
               angular.forEach(vm.form.lotes, function (value, key) {
                  value.lote.vencimento = Date.parse(value.lote.vencimento);
                  VacinaTemLoteFactory.get({ lote_id: value.lote.id }).then(function (response) {
                     if (response.data.success === true && response.data.result.quantidade) {
                        value.lote.quantidade = response.data.result.quantidade;
                        value.lote.vacina_tem_lote_id = response.data.result.id;
                     }
                  });
               });
            });
         }
      }

      function updateSelection(entry, entities) {
         cancelLote();
         vm.vacina = entry;
         angular.forEach(entities, function (subscription, index) {
            if (entry.id != subscription.id) {
               subscription.checked = false;
            }
         });
      }

      function cancelLote() {
         vm.form.lotes = [];
         vm.lote = null;
      }

      vm.today = function (lote) {
         lote.vencimento = new Date();
      }
      vm.clearDate = function (lote) {
         lote.data_hora = null;
      }
      vm.disabled = disabled;
      vm.toggleMin = toggleMin;
      vm.openDate = function (lote) {
         lote.popup = true;
      }
      vm.setDate = setDate;

      vm.formats = ['dd/MM/yyyy', 'dd-MMMM-yyyy', 'shortDate'];
      vm.format = vm.formats[0];
      vm.altInputFormats = ['d!/M!/yyyy'];

      vm.inlineOptions = {
         customClass: getDayClass,
         minDate: new Date(),
         showWeeks: true
      };

      vm.dateOptions = {
         dateDisabled: disabled,
         formatYear: 'yyyy',
         maxDate: new Date(new Date().getDate() + 1),
         minDate: new Date(new Date().getDate() - 30),
         startingDay: 1
      }

      //disabled weekend selection
      function disabled(data) {
         var date = data.date,
         mode = data.mode;
         return mode == 'day' && (date.getDay() === 0 || date.getDay() === 6);
      }

      function toggleMin() {
         vm.inlineOptions.minDate = vm.inlineOptions.minDate ? null : new Date();
         vm.dateOptions.minDate = vm.inlineOptions.minDate;
      }

      vm.toggleMin();

      function setDate(lote, year, month, day) {
         lote.vencimento = new Date(year, month, day);
      }

      function getDayClass(data) {
         var date = data.date,
         mode = data.mode;
         if (mode === 'day') {
            var dayToCheck = new Date(date).setHours(0, 0, 0, 0);

            for (var i = 0; i < vm.events.length; i++) {
               var currentDay = new Date(vm.events[i].date).setHours(0, 0, 0, 0);

               if (dayToCheck === currentDay) {
                  return vm.events[i].status;
               }
            }
         }
         return '';
      }
   }

   VacinaFactory.$inject = ['$http', 'Fluffy'];

   function VacinaFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var VacinaFactory = {
         get: get,
         add: add,
         alt: alt,
         del: del
      };
      return VacinaFactory;

      function get() {
         return $http.get(
            _url + '/vacina'
         )
         .then(success)
         .catch(failed);

         function success(response) {
            return response;
         }

         function failed(response) {
            return response;
         }
      }

      function add(data) {
         return $http({
            url: _url + '/vacina',
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
            url: _url + '/vacina',
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
            url: _url + '/vacina',
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
