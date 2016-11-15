(function() {
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

    $rootScope.$on('$locationChangeStart', function(event, next, current) {
      var publicPages = ['/login'];
      var restrictedPage = publicPages.indexOf($location.path()) === -1;
      if (restrictedPage && !$window.localStorage.currentUser) {
        $location.path('/login');
      }
    });

    return authService;

    function login(username, password, callback) {
      //SUBSTITUIR PELO CÓDIGO ABAIXO
      // if (username === 'teste' && password === 'teste') {
      //   $window.localStorage.currentUser = {
      //     username: username,
      //     token: 'myToken'
      //   }
      //   $http.defaults.headers.common.Authorization = 'Bearer ' + 'myToken';
      //   callback(true);
      // } else {
      //   callback(false);
      // }
      $http({
          url: _url + '/login',
          data: {
            usuario: username,
            senha: null,
            client_id: Fluffy.clientId
          },
          method: 'POST'
        })
        .then(function(response) {
          if (response.data.result.token) {
            var _token = response.data.result.token;

            $window.localStorage.currentUser = JSON.stringify({
              username: username,
              token: _token
            });

            $http.defaults.headers.common.Authorization = _token;
            callback(_token);
          } else {
            callback(false);
          }
        })
        .catch(function(response){
          console.log('failed login', response);
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
