(function() {
  'use strict';

  angular
    .module('Fluffy', ['ngResource', 'ngRoute', 'angular-storage', 'xeditable', 'ui.select',
      'ngDragDrop', 'angularMoment', 'mwl.calendar', 'ui.bootstrap', 'Index', 'Pessoa',
      'Funcao', 'Permissao', 'RedeSocial', 'GrupoItem', 'Servico', 'Agenda', 'Agendamento',
      'Consulta', 'Lembrete', 'PessoaTemFuncao', 'PessoaTemRedeSocial', 'Telefone', 'Animal',
      'Estoque', 'Venda', 'modalServiceModule', 'dataStorageService',
      'Authentication', 'Login', 'Raca', 'Porte', 'Especie', 'Restricao', 'Configuracao',
      'Lote', 'Vacina', 'angularUtils.directives.dirPagination', 'Anamnese', 'AnimalTemRestricao',
      'ServicoTemPorte', 'Funcionario', 'Aplicacao', 'ngToast', 'Transacao'
    ])
    .config(['$routeProvider', '$locationProvider', '$httpProvider', 'calendarConfig', 'uibDatepickerPopupConfig', 'ngToastProvider',
      function($routeProvider, $locationProvider, $httpProvider, calendarConfig, uibDatepickerPopupConfig, ngToastProvider) {
        $httpProvider.defaults.cache = false;
        $locationProvider.html5Mode(false);
        $httpProvider.defaults.headers.post["Content-Type"] = "application/json;charset=UTF-8";
        $httpProvider.defaults.headers.put["Content-Type"] = "application/json;charset=UTF-8";
        $httpProvider.defaults.headers.delete = {
          'Content-Type': 'application/json;charset=UTF-8'
        };
        $httpProvider.defaults.headers.get = {
          'Content-Type': 'application/json;charset=UTF-8'
        };
        $routeProvider
          .when('/login', {
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
          .otherwise('/erro');
        uibDatepickerPopupConfig.startingDay = 1;
        uibDatepickerPopupConfig.showWeeks = true;
        uibDatepickerPopupConfig.currentText = "Hoje";
        uibDatepickerPopupConfig.clearText = "Limpar";
        uibDatepickerPopupConfig.closeText = "Fechar";

        calendarConfig.i18nStrings.weekNumber = 'Semana {week}';

        ngToastProvider.configure({
          animation: 'fade'
        , horizontalPosition: 'left'
        , verticalPosition: 'bottom'
        });
      }
    ])
    .run(function(editableOptions, $rootScope, $http, $location, $window) {
      editableOptions.theme = 'bs3';
    })
    .filter('capitalize', function() {
      // Create the return function and set the required parameter as well as an optional paramater
      return function(input, char) {

        if (isNaN(input)) {

          // If the input data is not a number, perform the operations to capitalize the correct letter.
          var char = char - 1 || 0;
          var letter = input.charAt(char).toUpperCase();
          var out = [];

          for (var i = 0; i < input.length; i++) {

            if (i == char) {
              out.push(letter);
            } else {
              out.push(input[i]);
            }

          }

          return out.join('');

        } else {
          return input;
        }

      }
    })
    .filter('dateToISO', function() {
      return function(badTime) {
        var goodTime = badTime.replace(/(.+) (.+)/, "$1T$2Z");
        return goodTime;
      }
    });
})()
