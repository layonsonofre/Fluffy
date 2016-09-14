'use strict';

angular
	.module('Lembrete', [])
	.controller('LembreteController', LembreteController)
	.factory('LembreteFactory', LembreteFactory);

	LembreteController.$inject = ['$scope', '$http', 'LembreteFactory'];
	function LembreteController($scope, $http, LembreteFactory) {
		var vm = this;
    vm.newField = {};
		vm.editing = false;
		vm.fields = [
			{ "id": "1", "lembrete": "Reunião às 10h" },
			{ "id": "2", "lembrete": "Pagar a conta de luz R$ 93,00" },
			{ "id": "3", "lembrete": "Cliente grande às 14h" }
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

	LembreteFactory.$inject = ['$http'];
	function LembreteFactory($http) {
		var urlBase = '/cliente/cadastro';
		var LembreteFactory = {
			getRedesSociais: getRedesSociais
		};
		return LembreteFactory;

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
