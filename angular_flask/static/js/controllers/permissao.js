'use strict';

angular
	.module('Permissao', [])
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
			.when('/permissao', {
				templateUrl: '../static/partials/avancado/permissao.html',
				controller: 'PermissaoController',
				controllerAs: 'Permissao'
			})
	}])
	.controller('PermissaoController', PermissaoController);

	PermissaoController.$inject = ['$scope'];
  function PermissaoController($scope) {
		$scope.newField = {};
		$scope.editing = false;
		$scope.fields = [
			{ "id": "1", "nome": "Transportar" },
			{ "id": "2", "nome": "Consultar" },
			{ "id": "3", "nome": "Vender" }
		];
		$scope.editar = function(field) {
			$scope.editing = $scope.fields.indexOf(field);
			$scope.newField = angular.copy(field);
		}
		$scope.salvar = function(field) {
			//TODO CODE
		}
		$scope.cancelar = function(index) {
			if($scope.editing !== false) {
				$scope.fields[$scope.editing] = $scope.newField;
				$scope.editing = false;
			}
		}
		$scope.excluir = function(field) {
			//TODO CODE
		}
	}
