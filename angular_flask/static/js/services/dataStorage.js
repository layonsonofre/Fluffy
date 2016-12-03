(function() {
   'use strict';

   angular
   .module('dataStorageService', [])
   .service('dataStorage', dataStorage);

   dataStorage.$inject = ['$window', '$rootScope'];

   function dataStorage($window, $rootScope) {
      var dataStorage = {};

      dataStorage.cleanUp = cleanUp;

      dataStorage.addPessoa = addPessoa;
      dataStorage.getPessoa = getPessoa;
      
      dataStorage.addAnimal = addAnimal;
      dataStorage.getAnimal = getAnimal;

      dataStorage.addContrato = addContrato;
      dataStorage.getContrato = getContrato;

      dataStorage.addAgendamento = addAgendamento;
      dataStorage.getAgendamento = getAgendamento;

      dataStorage.addVenda = addVenda;
      dataStorage.getVenda = getVenda;

      dataStorage.getUser = getUser;

      dataStorage.addPermissoes = addPermissoes;
      dataStorage.getPermissoes = getPermissoes;
      dataStorage.checkPermission = checkPermission;

      return dataStorage;

      function cleanUp() {
         $window.localStorage.currentPessoa = null;
         $window.localStorage.currentAgendamento = null;
         $window.localStorage.currentAnimal = null;
         $window.localStorage.currentContrato = null;
         $window.localStorage.currentVenda = null;
      }

      //pessoa
      function addPessoa(entry) {
         $window.localStorage.currentPessoa = JSON.stringify(entry);
      }

      function getPessoa() {
         if ($window.localStorage.currentPessoa) {
            return JSON.parse($window.localStorage.currentPessoa);
         }
         return null;
      }

      //animal
      function addAnimal(entry) {
         $window.localStorage.currentAnimal = JSON.stringify(entry);
      }

      function getAnimal() {
         if ($window.localStorage.currentAnimal) {
            return JSON.parse($window.localStorage.currentAnimal);
         }
         return null;
      }

      //contrato
      function addContrato(entry) {
         $window.localStorage.currentContrato = entry;
      }

      function getContrato() {
         if ($window.localStorage.currentContrato) {
            return JSON.parse($window.localStorage.currentContrato);
         }
         return null;
      }

      //agendamento
      function addAgendamento(entry) {
         $window.localStorage.currentAgendamento = entry;
      }

      function getAgendamento() {
         if ($window.localStorage.currentAgendamento) {
            return JSON.parse($window.localStorage.currentAgendamento);
         }
         return null;
      }

      //venda
      function addVenda(entry) {
         $window.localStorage.currentVenda = JSON.stringify(entry);
      }

      function getVenda() {
         if ($window.localStorage.currentVenda != null) {
            return JSON.parse($window.localStorage.currentVenda);
         }
         return null;
      }

      //user
      function getUser() {
         if ($window.localStorage.currentUser) {
            return JSON.parse($window.localStorage.currentUser);
         }
         return null;
      }

      //permissoes
      function addPermissoes(entry) {
         $window.localStorage.currentPermissoes = JSON.stringify(entry);

         $rootScope.permissoes = {};
         angular.forEach(getPermissoes(), function (value, key) {
            if (value.modulo === 'Cadastro') {
               $rootScope.permissoes.cadastro = true;
            }
            if (value.modulo === 'Venda') {
               $rootScope.permissoes.venda = true;
            }
            if (value.modulo === 'Servico') {
               $rootScope.permissoes.servico = true;
            }
            if (value.modulo === 'Consulta') {
               $rootScope.permissoes.consulta = true;
            }
         });
      }

      function getPermissoes() {
         if ($window.localStorage.currentPermissoes) {
            return JSON.parse($window.localStorage.currentPermissoes);
         }
         return null;
      }

      function checkPermission(desired) {
         var available = false;
         angular.forEach(getPermissoes(), function(value, key) {
            if (value.modulo === desired) {
               available = true;
            }
         });
         return available;
      }

   }
})()
