(function() {
  'use strict';

  angular
    .module('Login', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/login', {
          templateUrl: '../static/partials/login.html',
          controller: 'LoginController',
          controllerAs: 'vm'
        });
    }])
    .controller('LoginController', LoginController);

  LoginController.$inject = ['AuthService', '$location', '$rootScope', 'dataStorage', 'PessoaTemFuncaoFactory', 'PermissaoFactory', 'ngToast'];

  function LoginController(AuthService, $location, $rootScope, dataStorage, PessoaTemFuncaoFactory, PermissaoFactory, ngToast) {
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
        if (result === false) {
          ngToast.danger({content: 'Falha ao realizar conexão, verifique se suas credenciais estão corretas.'});
          vm.loading = false;
        } else {
          $location.path('/overview');
        }
      });
    };
  }
})()
