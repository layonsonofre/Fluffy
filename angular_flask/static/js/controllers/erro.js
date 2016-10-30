(function() {
  'use strict';

  angular
    .module('Erro', [])
    .controller('ErroController', ErroController);

  ErroController.$inject = ['$scope'];

  function ErroController($scope) {
    var vm = this;

    vm.hideMenus = true;
  }
})()
