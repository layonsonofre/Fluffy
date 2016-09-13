'use strict';

angular
	.module('AngularFlask', ['ngRoute', 'ngResource', 'Index', 'Cliente', 'Funcao', 'Permissao', 'RedeSocial', 'GrupoItem', 'Servico', 'Consulta', 'Lembrete', 'Estoque', 'Venda', 'ngDragDrop'])
	.config(['$routeProvider', '$locationProvider','$httpProvider',
		function($routeProvider, $locationProvider, $httpProvider) {
			$httpProvider.defaults.headers.common["X-Requested-With"] = undefined;
			$locationProvider.html5Mode(true);
			$routeProvider
				.when('/', {
					templateUrl: '../static/partials/overview.html',
					controller: 'IndexController',
					controllerAs: 'Index'
				})
				.otherwise({redirectTo: '/'});
	}]);
