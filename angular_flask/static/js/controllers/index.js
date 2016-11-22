(function() {
  'use strict';

  angular
    .module('Index', [])
    .controller('IndexController', IndexController);

  IndexController.$inject = ['$rootScope', 'dataStorage'];

  function IndexController($rootScope, dataStorage) {
    $rootScope.hideMenu = false;
    $rootScope.bodyBackground = '';

    $rootScope.permissoes = {};
    angular.forEach(dataStorage.getPermissoes(), function(value, key) {
      console.log("permissao", value);
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
})()
