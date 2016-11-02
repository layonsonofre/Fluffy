(function() {
  'use strict';

  angular
    .module('Login', [])
    .controller('LoginController', LoginController);

  LoginController.$inject = ['AuthService', '$location', '$rootScope', 'dataStorage'];

  function LoginController(AuthService, $location, $rootScope, dataStorage) {
    var vm = this;
    vm.login = login;
    vm.logout = logout;

    $rootScope.hideMenu = true;
    $rootScope.bodyBackground = 'body-background';
    vm.helpActive = false;

    logout();

    function logout() {
      AuthService.logout();
      dataStorage.cleanUp();
    }

    function login() {
      vm.loading = true;
      AuthService.login(vm.email, vm.senha, function(result) {
        if (result === true) {
          $location.path('#/overview');
        } else {
          vm.error = 'Credenciais incorretas.';
          vm.loading = false;
        }
      });
    };
  }
})()
