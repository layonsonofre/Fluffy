'use strict';

angular
	.module('RedeSocial', [])
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
			.when('/redeSocial', {
				templateUrl: '../static/partials/avancado/redeSocial.html',
				controller: 'RedeSocialController',
				controllerAs: 'RedeSocial'
			})
	}])
	.controller('RedeSocialController', RedeSocialController);

	RedeSocialController.$inject = ['$scope', '$http'];
  function RedeSocialController($scope) {
		$scope.newField = {};
		$scope.editing = false;
		$scope.fields = [
			{ "id": "1", "nome": "Facebook" },
			{ "id": "2", "nome": "Instagram" },
			{ "id": "3", "nome": "Whatsapp" }
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
