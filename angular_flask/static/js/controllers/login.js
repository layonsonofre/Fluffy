(function() {
  'use strict';

  angular
    .module('Login', [])
    .controller('LoginController', LoginController);

  LoginController.$inject = ['AuthService', '$location', '$rootScope', 'dataStorage', 'PessoaTemFuncaoFactory', 'PermissaoFactory'];

  function LoginController(AuthService, $location, $rootScope, dataStorage, PessoaTemFuncaoFactory, PermissaoFactory) {
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
        if (result != false) {
          $location.path('/overview');
        } else {
          vm.error = 'Falha ao realizar conexão, verifique se suas credenciais estão corretas.';
          vm.loading = false;
        }
      });
    };
  }
})()
