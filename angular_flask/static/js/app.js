(function() {
   'use strict';

   angular
      .module('Fluffy', ['ngRoute', 'ngResource', 'xeditable',
         'ngDragDrop', 'angularMoment', 'mwl.calendar', 'ui.bootstrap', 'Index', 'Cliente',
         'Funcao', 'Permissao', 'RedeSocial', 'GrupoItem', 'Servico', 'Consulta', 'Lembrete',
         'Estoque', 'Venda', 'Estatisticas'
      ])
      .config(['$routeProvider', '$locationProvider', '$httpProvider', 'calendarConfig', 'uibDatepickerPopupConfig',
         function($routeProvider, $locationProvider, $httpProvider, calendarConfig, uibDatepickerPopupConfig) {
            $httpProvider.defaults.cache = false;
            $httpProvider.defaults.headers.post["Content-Type"] = "application/json";
            $httpProvider.defaults.headers.put["Content-Type"] = "application/json";
            $locationProvider.html5Mode(true);
            $routeProvider
               .when('/', {
                  templateUrl: '../static/partials/overview.html',
                  controller: 'IndexController',
                  controllerAs: 'vm'
               })
               .otherwise({
                  redirectTo: '/'
               });
           uibDatepickerPopupConfig.startingDay = 1;
           uibDatepickerPopupConfig.showWeeks = true;
           uibDatepickerPopupConfig.currentText = "Hoje";
           uibDatepickerPopupConfig.clearText = "Limpar";
           uibDatepickerPopupConfig.closeText = "Fechar";

           calendarConfig.i18nStrings.weekNumber = 'Semana {week}';
         }
      ])
      .run(function(editableOptions) {
         editableOptions.theme = 'bs3';
      });
})()
