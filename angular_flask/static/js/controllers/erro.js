(function() {
   'use strict';

   angular
   .module('Erro', [])
   .controller('ErroController', ErroController);

   ErroController.$inject = ['$rootScope'];

   function ErroController($rootScope) {
      var vm = this;
      // vm.hideMenus = false;
      $rootScope.hideMenu = false;
      $rootScope.bodyBackground = '';
   }
})()
