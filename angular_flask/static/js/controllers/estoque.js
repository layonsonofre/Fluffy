'use strict';

angular
	.module('Estoque', [])
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
			.when('/estoque/cadastro', {
				templateUrl: '../static/partials/estoque/cadastro.html',
				controller: 'ProdutoController',
				controllerAs: 'Produto'
			})
			.when('/estoque/busca', {
				templateUrl: '../static/partials/estoque/busca.html',
				controller: 'ProdutoController',
				controllerAs: 'Produto'
			})
	}])
	.controller('ProdutoController', ProdutoController)
	.factory('ProdutoFactory', ProdutoFactory);

	ProdutoController.$inject = ['$scope', '$http', 'ProdutoFactory'];
	function ProdutoController($scope, $http, ProdutoFactory) {
		$scope.produtos = [{'id': 0, 'nome': 'X-doggy-dog', 'valor':'10,00'}, {'id': 1, 'nome': 'Zendog', 'valor':'37,00'}];
	}

	ProdutoFactory.$inject = ['$http'];
	function ProdutoFactory($http) {
		var urlBase = '/cliente/cadastro';
		var ProdutoFactory = {
			getRedesSociais: getRedesSociais
		};
		return ProdutoFactory;

		function getRedesSociais() {
			return $http.get(urlBase + '/tipoRedeSocial')
				.then(getRedesSociaisComplete)
				.catch(getRedesSociaisFailed);

				function getRedesSociaisComplete(response) {
					return response.data.results;
				}

				function getRedesSociaisFailed(error) {
					console.error('Failed getRedesSociais: ' + error.data);
				}
		}
	}
