(function() {
   'use strict';

   angular
      .module('Fluffy', ['ngRoute', 'ngResource', 'xeditable', 'ui.bootstrap', 'Index', 'Cliente',
         'Funcao', 'Permissao', 'RedeSocial', 'GrupoItem', 'Servico', 'Consulta', 'Lembrete',
         'Estoque', 'Venda', 'Estatisticas', 'ngDragDrop'
      ])
      .config(['$routeProvider', '$locationProvider', '$httpProvider',
         function($routeProvider, $locationProvider, $httpProvider) {
            $httpProvider.defaults.cache = false;
            $httpProvider.defaults.headers.common["X-Requested-With"] = undefined;
            $httpProvider.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
            $httpProvider.defaults.headers.put["Content-Type"] = "application/x-www-form-urlencoded";
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
