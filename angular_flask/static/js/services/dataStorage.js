(function() {
  'use strict';

  angular
    .module('dataStorageService', [])
    .service('dataStorage', dataStorage);

  dataStorage.$inject = [];

  function dataStorage() {
    this.animal = {};
    this.servico = {};
  }
})()
