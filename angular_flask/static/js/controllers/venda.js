(function() {
  'use strict';

  angular
    .module('Venda', [])
    .config(['$routeProvider', function($routeProvider) {
      $routeProvider
        .when('/venda/nova', {
          templateUrl: '../static/partials/venda/nova.html',
          controller: 'VendaController',
          controllerAs: 'vm'
        })
        .when('/venda/confirmacao', {
          templateUrl: '../static/partials/venda/confirmacao.html',
          controller: 'VendaController',
          controllerAs: 'vm'
        })
    }])
    .controller('VendaController', VendaController);
    // .factory('VendaFactory', VendaFactory);

  VendaController.$inject = ['modalService', 'PessoaFactory', 'PessoaTemFuncaoFactory'
      , '$window', '$filter', '$location', 'dataStorage', 'ProdutoFactory', 'TelefoneFactory'];

  function VendaController(modalService, PessoaFactory, PessoaTemFuncaoFactory
      , $window, $filter, $location, dataStorage, ProdutoFactory, TelefoneFactory) {

    var vm = this;

    if (!dataStorage.checkPermission('Venda')) {
      $location.path('/erro');
      $location.replace();
    }

    vm.updateSelection = updateSelection;
    vm.detalhes_pessoa = detalhes_pessoa;
    vm.getClientes = getClientes;
    vm.getProdutos = getProdutos;
    vm.addToCart = addToCart;
    vm.removeFromCart = removeFromCart;
    vm.increase = increase;
    vm.decrease = decrease;
    vm.cartTotal = cartTotal;
    vm.calcParcelas = calcParcelas;

    vm.cliente = {};
    vm.cart = [];
    vm.parcelas = 1;
    if (vm.cart) {
      cartTotal();
    }
    getClientes();
    getProdutos();

    var venda = dataStorage.getVenda();
    if (venda != null) {
      console.log("venda", venda);
      vm.cart_total = venda.cart_total;
      vm.cliente_nome = venda.cliente_nome;
    }

    function getClientes() {
      PessoaFactory.get({cliente: true}).then(function(response) {
        vm.pessoas = response;
      });
    }

    function getProdutos() {
      ProdutoFactory.get().then(function(response) {
        console.log(response);
        vm.produtos = response.data.result;
      });
    }

    function addToCart(entry) {
      var itemJaAdicionado = false;
      for (var i = 0; i < vm.cart.length; i++) {
        if (vm.cart[i].id === entry.id) {
          itemJaAdicionado = true;
          break;
        }
      }
      if (itemJaAdicionado === false) {
        vm.cart.push({
          id: entry.id,
          nome: entry.nome,
          preco: entry.preco,
          quantidade: 1,
          max_quantidade: entry.quantidade
        });
        cartTotal();
        calcParcelas();
      }
    }

    function removeFromCart(entry) {
      vm.cart[vm.cart.indexOf(entry)] = vm.cart.splice(vm.cart.indexOf(entry), 1);
      if (vm.cart.length === 1) {
        vm.cart = [];
      }
      cartTotal();
    }

    function increase(entry) {
      var quantidade = parseInt(entry.quantidade);
      if (quantidade < entry.max_quantidade) {
        quantidade += 1;
        vm.cart[vm.cart.indexOf(entry)].quantidade = quantidade;
      }
      cartTotal();
    }

    function decrease(entry) {
      var quantidade = parseInt(entry.quantidade);
      quantidade -= 1;
      vm.cart[vm.cart.indexOf(entry)].quantidade = quantidade;
      cartTotal();
    }

    function cartTotal() {
      var _total = 0;
      for (var i = 0; i < vm.cart.length; i++) {
        _total += vm.cart[i].preco*vm.cart[i].quantidade;
      }
      vm.cart_total = _total;
    }

    function calcParcelas() {
      vm.valor_parcela = vm.cart_total/vm.parcelas;
    }

    vm.gotoConfirmacao = function() {
      dataStorage.addVenda({
        cart_total: vm.cart_total,
        cliente_nome: vm.cliente.nome
      });
      $location.path('/venda/confirmacao');
    }

    vm.gotoNova = function() {
      dataStorage.addVenda(null);
      $location.path('/venda/nova');
    }

    function detalhes_pessoa(entry) {
      vm.pessoa = {};
      vm.pessoa = entry;
      var telefones = [];
      TelefoneFactory.get({
        pessoa_id: entry.id
      }).then(function(response) {
        if (!angular.isArray(response)) {
          telefones.push(response);
        } else {
          telefones = response;
        }
        var temp = '';
        angular.forEach(telefones, function(value, key) {
          temp += '(' + value.codigo_area + ') ' + value.numero + '   '
        });
        vm.pessoa.telefone = temp;
      });
    }

    function updateSelection(entry, entities) {
      angular.forEach(entities, function(subscription, index) {
        if (entry.id != subscription.id) {
          subscription.checked = false;
        } else {
          vm.cliente = entry;
        }
      });
    }
  }
})()
