(function () {
  'use strict';

  angular
    .module('Authentication', [])
    .factory('AuthService', AuthService);

  AuthService.$inject = ['$rootScope', '$location', '$http', '$window', 'Fluffy'];

  function AuthService($rootScope, $location, $http, $window, Fluffy) {

    var _url = Fluffy.urlBase;
    var authService = {};
    authService.login = login;
    authService.logout = logout;
    authService.isAuthenticated = isAuthenticated;

    $rootScope.$on('$locationChangeStart', function (event, next, current) {
      var publicPages = ['/login'];
      var restrictedPage = publicPages.indexOf($location.path()) === -1;
      if (restrictedPage && !$window.localStorage.currentUser) {
        $location.path('/login');
      }
    });

    return authService;

    function login(username, password, callback) {
      $http({
          url: _url + '/login',
          data: {
            usuario: username,
            senha: password,
            client_id: Fluffy.clientId
          },
          method: 'POST'
        })
        .then(function (response) {
          if (response.data.success === true) {
            var _token = response.data.result.token;
            $http.defaults.headers.common.Authorization = "Bearer " + _token;

            $http({
              url: _url + '/getPermissoes',
              method: 'GET'
            }).then(function (response) {
              $window.localStorage.currentUser = JSON.stringify({
                username: username,
                token: _token,
                pessoa_id: response.data.result.pessoa.id,
                registro: response.data.result.pessoa.registro
              });
              $window.localStorage.currentPermissoes = JSON.stringify(response.data.result.modulos);
              callback(_token);
            });

          } else {
            callback(false);
          }
        })
        .catch(function (response) {
          callback(false);
        });
    }

    function logout() {
      delete $window.localStorage.currentUser;
      $http.defaults.headers.common.Authorization = '';
    }

    function isAuthenticated() {
      if ($window.localStorage.currentUser) {
        return true;
      }
      return false;
    }
  }
})()
