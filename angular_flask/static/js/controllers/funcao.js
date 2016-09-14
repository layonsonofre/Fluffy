'use strict';

angular
	.module('Funcao', [])
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
			.when('/funcao', {
				templateUrl: '../static/partials/avancado/funcao.html',
				controller: 'FuncaoController',
				controllerAs: 'Funcao'
			})
	}])
	.controller('FuncaoController', FuncaoController);

	FuncaoController.$inject = ['$scope', '$http'];
  function FuncaoController($scope) {
		$scope.newField = {};
		$scope.editing = false;
		$scope.fields = [
			{ "id": "1", "nome": "Cliente" },
			{ "id": "2", "nome": "Cliente Especial" },
			{ "id": "3", "nome": "Funcionário" },
			{ "id": "4", "nome": "Caixa" }
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
