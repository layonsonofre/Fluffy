(function() {
  'use strict';

  angular
    .module('dataStorageService', [])
    .service('dataStorage', dataStorage);

  dataStorage.$inject = ['$window'];

  function dataStorage($window) {
    var dataStorage = {};

    dataStorage.cleanUp = cleanUp;

    dataStorage.addPessoa = addPessoa;
    dataStorage.getPessoa = getPessoa;

    dataStorage.addAgendamento = addAgendamento;
    dataStorage.getAgendamento = getAgendamento;

    return dataStorage;

    function cleanUp() {
      $window.localStorage.currentPessoa = JSON.stringify({});
      $window.localStorage.currentAgendamento = JSON.stringify({});
    }

    //pessoa
    function addPessoa(entry) {
      $window.localStorage.currentPessoa = JSON.stringify(entry);
    }

    function getPessoa() {
      if ($window.localStorage.currentPessoa) {
        return JSON.parse($window.localStorage.currentPessoa);
      }
      return {};
    }

    //agendamento
    function addAgendamento(entry) {
      $window.localStorage.currentAgendamento = JSON.stringify(entry);
    }

    function getAgendamento() {
      if ($window.localStorage.currentAgendamento) {
        return JSON.parse($window.localStorage.currentAgendamento);
      }
      return {};
    }

  }
})()
