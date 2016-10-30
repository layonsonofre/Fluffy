(function() {
  'use strict';

  angular
    .module('Fluffy', ['ngResource', 'ngRoute', 'angular-storage', 'xeditable',
      'ngDragDrop', 'angularMoment', 'mwl.calendar', 'ui.bootstrap', 'Index', 'Cliente',
      'Funcao', 'Permissao', 'RedeSocial', 'GrupoItem', 'Servico', 'Consulta', 'Lembrete',
      'Estoque', 'Venda', 'Estatisticas', 'modalServiceModule', 'dataStorageService',
      'Authentication', 'Login'
    ])
    .config(['$routeProvider', '$locationProvider', '$httpProvider', 'calendarConfig', 'uibDatepickerPopupConfig',
      function($routeProvider, $locationProvider, $httpProvider, calendarConfig, uibDatepickerPopupConfig) {
        $httpProvider.defaults.cache = false;
        $httpProvider.defaults.headers.post["Content-Type"] = "application/json";
        $httpProvider.defaults.headers.put["Content-Type"] = "application/json";
        $locationProvider.html5Mode(true);
        $routeProvider
          .when('/api/login', {
            templateUrl: '../static/partials/login.html',
            controller: 'LoginController',
            controllerAs: 'vm'
          })
          .when('/erro', {
            templateUrl: '../static/partials/erro.html',
            controller: 'ErroController',
            controllerAs: 'vm'
          })
          .when('/overview', {
            templateUrl: '../static/partials/overview.html',
            controller: 'IndexController',
            controllerAs: 'vm'
          })
          .otherwise('/api/login');
        uibDatepickerPopupConfig.startingDay = 1;
        uibDatepickerPopupConfig.showWeeks = true;
        uibDatepickerPopupConfig.currentText = "Hoje";
        uibDatepickerPopupConfig.clearText = "Limpar";
        uibDatepickerPopupConfig.closeText = "Fechar";

        calendarConfig.i18nStrings.weekNumber = 'Semana {week}';
      }
    ])
    .run(function(editableOptions, $rootScope, $http, $location, $window) {
      editableOptions.theme = 'bs3';

      // keep user logged in after page refresh
      if ($window.localStorage.currentUser) {
        $http.defaults.headers.common.Authorization = 'Bearer ' + $window.localStorage.currentUser.token;
      }

      // redirect to login page if not logged in and trying to access a restricted page
      $rootScope.$on('$locationChangeStart', function(event, next, current) {
        var publicPages = ['/api/login'];
        var restrictedPage = publicPages.indexOf($location.path()) === -1;
        if (restrictedPage && !$window.localStorage.currentUser) {
          $location.path('/api/login');
        }
      });
    });
})()
