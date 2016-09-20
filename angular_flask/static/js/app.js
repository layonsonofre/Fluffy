(function() {
   'use strict';

   angular
      .module('Fluffy', ['ngRoute', 'ngResource', 'xeditable', 'ui.bootstrap', 'Index', 'Cliente',
         'Funcao', 'Permissao', 'RedeSocial', 'GrupoItem', 'Servico', 'Consulta', 'Lembrete',
         'Estoque', 'Venda', 'Estatisticas', 'ngDragDrop', 'ui.calendar'
      ])
      .config(['$routeProvider', '$locationProvider', '$httpProvider',
         function($routeProvider, $locationProvider, $httpProvider) {
            $httpProvider.defaults.cache = false;
            $httpProvider.defaults.headers.post["Content-Type"] = "application/json";
            $httpProvider.defaults.headers.put["Content-Type"] = "application/json";
            $locationProvider.html5Mode(true);
            $routeProvider
               .when('/', {
                  templateUrl: '../static/partials/overview.html',
                  controller: 'IndexController',
                  controllerAs: 'Index'
               })
               .otherwise({
                  redirectTo: '/'
               });
         }
      ])
      .run(function(editableOptions) {
         editableOptions.theme = 'bs3';
      });
})()
