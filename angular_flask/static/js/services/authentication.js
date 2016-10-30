(function() {
  'use strict';

  angular
    .module('Authentication', [])
    .factory('AuthService', AuthService);

  AuthService.$inject = ['$http', '$window'];

  function AuthService($http, $window) {
    var authService = {};
    authService.login = login;
    authService.logout = logout;
    authService.isAuthenticated = isAuthenticated;

    return authService;

    function login(username, password, callback) {
      //SUBSTITUIR PELO CÓDIGO ABAIXO
      if (username === 'teste' && password === 'teste') {
        $window.localStorage.currentUser = {
          username: username,
          token: 'myToken'
        }
        $http.defaults.headers.common.Authorization = 'Bearer ' + 'myToken';
        callback(true);
      } else {
        callback(false);
      }

      // $http.post('/login', {
      //     username: username,
      //     password: password
      //   })
      //   .success(function(response) {
      //     // login successful if there's a token in the response
      //     if (response.token) {
      //       // store username and token in local storage to keep user logged in between page refreshes
      //       $window.localStorage.currentUser = {
      //         username: username,
      //         token: response.token
      //       };
      //
      //       // add jwt token to auth header for all requests made by the $http service
      //       $http.defaults.headers.common.Authorization = 'Bearer ' + response.token;
      //
      //       // execute callback with true to indicate successful login
      //       callback(true);
      //     } else {
      //       // execute callback with false to indicate failed login
      //       callback(false);
      //     }
      //   });
    }

    function logout() {
      // remove user from local storage and clear http auth header
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
