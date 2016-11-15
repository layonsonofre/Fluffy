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

    dataStorage.addAnimal = addAnimal;
    dataStorage.getAnimal = getAnimal;

    dataStorage.addContrato = addContrato;
    dataStorage.getContrato = getContrato;

    dataStorage.getUser = getUser;

    dataStorage.addPermissoes = addPermissoes;
    dataStorage.getPermissoes = getPermissoes;
    dataStorage.checkPermission = checkPermission;

    return dataStorage;

    function cleanUp() {
      $window.localStorage.currentPessoa = JSON.stringify({});
      $window.localStorage.currentAgendamento = JSON.stringify({});
      $window.localStorage.currentAnimal = JSON.stringify({});
      $window.localStorage.currentContrato = JSON.stringify({});
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

    //agendamento
    function addContrato(entry) {
      $window.localStorage.currentContrato = entry;
    }

    function getContrato() {
      if ($window.localStorage.currentContrato) {
        return JSON.parse($window.localStorage.currentContrato);
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
