'use strict';

angular
	.module('Servico', [])
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
			.when('/servico/cadastro', {
				templateUrl: '../static/partials/servico/cadastro.html',
				controller: 'ServicoController',
				controllerAs: 'Servico'
			})
			.when('/servico/agendar', {
				templateUrl: '../static/partials/servico/agendar.html',
				controller: 'ServicoController',
				controllerAs: 'Servico'
			})
	}])
	.controller('ServicoController', ServicoController);

	ServicoController.$inject = ['$scope', 'ngDragDrop'];
  function ServicoController($scope) {
		$scope.servicos = [{'nome_servico': 'Banho'}, {'nome_servico': 'Tosa'}, {'nome_servico': 'Consulta'}];
		$scope.animais = [{'nome': 'Fluffy', 'sexo':'m', 'data':'15/08/1992', 'raca':'Pastor Alemão'}, {'nome': 'Bumma', 'sexo':'f', 'data':'28/11/2013', 'raca':'Beagle'}];
		$scope.servicosAgendados = [];
		$scope.removeServicosAgendados = function(index) {
			$scope.servicosAgendados.splice(index, 1);
		}
		$scope.animalAgendado = {'nome':''};
		$scope.removeAnimalAgendado = function() {
			$scope.animalAgendado = {'nome':''};
		}

		$scope.newField = {};
		$scope.editing = false;
		$scope.fields = [
			{ "id": "1", "nome": "Banho", "preco": "100,00" },
			{ "id": "2", "nome": "Tosa", "preco": "200,00" }
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
