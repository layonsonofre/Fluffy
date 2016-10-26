(function() {
  'use strict';

  angular
    .module('Venda', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/venda/nova', {
          templateUrl: '../static/partials/venda/nova.html',
          controller: 'VendaController',
          controllerAs: 'Venda'
        })
        .when('/venda/nova/pagamento', {
          templateUrl: '../static/partials/venda/pagamento.html',
          controller: 'VendaController',
          controllerAs: 'Venda'
        })
        .when('/venda/nova/confirmada', {
          templateUrl: '../static/partials/venda/confirmada.html',
          controller: 'VendaController',
          controllerAs: 'Venda'
        })
    }])
    .controller('VendaController', VendaController);

  VendaController.$inject = ['$scope'];

  function VendaController($scope) {
    $scope.carrinho = [];
    $scope.removeProduto = function(index) {
      $scope.carrinho.splice(index, 1);
    }
    $scope.increase = function(index) {
      var quantidade = parseInt($scope.carrinho[index].quantidade);
      quantidade += 1;
      $scope.carrinho[index].quantidade = quantidade;
    }
    $scope.decrease = function(index) {
      var quantidade = parseInt($scope.carrinho[index].quantidade);
      quantidade -= 1;
      $scope.carrinho[index].quantidade = quantidade;
    }
    $scope.adicionar = function(item) {
      var itemAdicionado = false;
      for (var i = 0, len = $scope.carrinho.length; i < len; i++) {
        if ($scope.carrinho[i].id === item.id) {
          itemAdicionado = true;
        }
      }
      if (itemAdicionado == false) {
        $scope.carrinho.push({
          id: item.id,
          nome: item.nome,
          valor: item.valor,
          quantidade: '1',
          valor_total: item.valor
        });
      }
    }
  }
})()
