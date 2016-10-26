(function() {
  'use strict';

  angular
    .module('GrupoItem', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/estoque/grupoItem', {
          templateUrl: '../static/partials/estoque/grupoItem.html',
          controller: 'GrupoItemController',
          controllerAs: 'GrupoItem'
        })
    }])
    .controller('GrupoItemController', GrupoItemController);

  GrupoItemController.$inject = ['$scope', '$http'];

  function GrupoItemController($scope) {
    $scope.newField = {};
    $scope.editing = false;
    $scope.fields = [{
      "id": "1",
      "nome": "Brinquedo"
    }, {
      "id": "2",
      "nome": "Coleira"
    }, {
      "id": "3",
      "nome": "Roupa"
    }, {
      "id": "3",
      "nome": "Gaiola"
    }];
    $scope.editar = function(field) {
      $scope.editing = $scope.fields.indexOf(field);
      $scope.newField = angular.copy(field);
    }
    $scope.salvar = function(field) {
      //TODO CODE
    }
    $scope.cancelar = function(index) {
      if ($scope.editing !== false) {
        $scope.fields[$scope.editing] = $scope.newField;
        $scope.editing = false;
      }
    }
    $scope.excluir = function(field) {
      //TODO CODE
    }
  }
})()
