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

    return dataStorage;

    function cleanUp() {
      $window.localStorage.currentPessoa = JSON.stringify({});
    }

    function addPessoa(entry) {
      $window.localStorage.currentPessoa = JSON.stringify(entry);
    }

    function getPessoa() {
      if ($window.localStorage.currentPessoa) {
        return JSON.parse($window.localStorage.currentPessoa);
      }
      return {};
    }

  }
})()
