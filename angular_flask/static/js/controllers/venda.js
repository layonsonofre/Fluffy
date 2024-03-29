(function () {
   'use strict';

   angular
   .module('Venda', [])
   .config(['$routeProvider', function ($routeProvider) {
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
      .when('/venda/lista', {
         templateUrl: '../static/partials/venda/lista.html',
         controller: 'VendaController',
         controllerAs: 'vm'
      })
   }])
   .controller('VendaController', VendaController)
   .factory('VendaFactory', VendaFactory);

   VendaController.$inject = ['VendaFactory', 'modalService', 'PessoaFactory', 'PessoaTemFuncaoFactory', '$window', '$filter', '$location', 'dataStorage', 'ProdutoFactory', 'TelefoneFactory', 'ngToast'];

   function VendaController(VendaFactory, modalService, PessoaFactory, PessoaTemFuncaoFactory, $window, $filter, $location, dataStorage, ProdutoFactory, TelefoneFactory, ngToast) {

      var vm = this;

      if (dataStorage.getUser() == null) {
         $location.path('/login');
         ngToast.danger({content: 'Necessário realizar o login antes de utilizar esta funcionalidade'});
      }

      if (!dataStorage.checkPermission('Venda')) {
         $location.path('/erro');
         ngToast.danger({content: 'Você não tem permissão para acessar esta funcionalidade'});
      }

      // if (!dataStorage.checkPermission('Venda')) {
      //    $location.path('/erro');
      //    $location.replace();
      // }

      vm.updateSelection = updateSelection;
      vm.detalhes_pessoa = detalhes_pessoa;
      vm.getClientes = getClientes;
      vm.getProdutos = getProdutos;
      vm.addToCart = addToCart;
      vm.removeFromCart = removeFromCart;
      vm.increase = increase;
      vm.decrease = decrease;
      vm.cartTotal = cartTotal;
      vm.selectPessoa = selectPessoa;
      vm.alt = alt;

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
         vm.cart_total = venda.cart_total;
         vm.cliente_nome = venda.cliente_nome;
      }

      function getClientes() {
         PessoaFactory.get({
            cliente: true
         }).then(function (response) {
            vm.pessoas = response.data.result;
         });
      }

      function getProdutos() {
         ProdutoFactory.get().then(function (response) {
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
               item_id: entry.id,
               nome: entry.nome,
               preco: entry.preco,
               quantidade: 1,
               max_quantidade: entry.quantidade
            });
            cartTotal();
         }
      }

      function removeFromCart(entry) {
         vm.cart.splice(vm.cart.indexOf(entry), 1);
         if (vm.cart.length === 0) {
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
            _total += vm.cart[i].preco * vm.cart[i].quantidade;
         }
         vm.cart_total = _total;
      }

      vm.gotoConfirmacao = function () {
         vm.pessoa_tem_funcao_funcionario_id = dataStorage.getUser().pessoa_tem_funcao_id;
         vm.pago = vm.pago ? 1 : 0;
         var send = {
            pessoa_tem_funcao_funcionario_id: vm.pessoa_tem_funcao_funcionario_id,
            pessoa_tem_funcao_cliente_id: vm.pessoa_tem_funcao_cliente_id,
            desconto: vm.desconto,
            pago: vm.pago,
            valor: vm.cart_total,
            itens_de_venda: vm.cart
         };
         VendaFactory.add(send).then(function (response) {
            if (response.data.success === true) {
               console.log("\nADICIONADO", response);
               dataStorage.addVenda({
                  cart_total: vm.cart_total,
                  cliente_nome: vm.cliente.nome
               });
               $location.path('/venda/confirmacao');
            } else {
               ngToast.danger({content: 'Falha ao adicionar realizar venda: ' + response.data.message});
            }
         });
      }

      vm.gotoNova = function () {
         dataStorage.addVenda(null);
         $location.path('/venda/nova');
      }

      function detalhes_pessoa(entry) {
         vm.pessoa = {};
         vm.pessoa = entry;
         var telefones = [];
         TelefoneFactory.get({
            pessoa_id: entry.id
         }).then(function (response) {
            if (!angular.isArray(response.data.result)) {
               telefones.push(response.data.result);
            } else {
               telefones = response.data.result;
            }
            var temp = '';
            angular.forEach(telefones, function (value, key) {
               temp += '(' + value.codigo_area + ') ' + value.numero + '   '
            });
            vm.pessoa.telefone = temp;
         });
      }

      function selectPessoa(entry) {
         vm.pessoa = entry;
         PessoaTemFuncaoFactory.get({
            pessoa_id: entry.id
         })
         .then(function (response) {
            vm.pessoa_tem_funcao_cliente_id = response.data.result.id;

            VendaFactory.get({ pessoa_tem_funcao_cliente_id: vm.pessoa_tem_funcao_cliente_id })
            .then(function (response) {
               vm.vendas = response.data.result;
            });
         });
      }


      function alt(entry) {
         console.log(entry);
         if (entry.pago || entry.pago === true) {
            entry.pago = 1;
         } else {
            entry.pago = 0;
         }
         var send = {
            pago: entry.pago,
            id: entry.id
         };
         VendaFactory.alt(send).then(function (response) {
            if (response.data.sucess === true) {
               ngToast.success({content: 'Venda ao alterada com sucesso'});
            } else {
               ngToast.warning({content: 'Falha ao alterar registro: ' + response.data.message})
            }
         });
      }

      function updateSelection(entry, entities) {
         angular.forEach(entities, function (subscription, index) {
            if (entry.id != subscription.id) {
               subscription.checked = false;
            } else {
               vm.cliente = entry;
            }
         });
      }
   }

   VendaFactory.$inject = ['$http', 'Fluffy'];

   function VendaFactory($http, Fluffy) {
      var _url = Fluffy.urlBase;
      var VendaFactory = {
         add: add,
         alt: alt,
         get: get
      };
      return VendaFactory;

      function add(data) {
         return $http({
            url: _url + '/insertPedido',
            data: data,
            method: 'POST'
         })
         .then(success)
         .catch(failed);

         function success(response) {
            return response;
         }

         function failed(response) {
            return response;
         }
      }

      function alt(data) {
         return $http({
            url: _url + '/pedido',
            data: data,
            method: 'PUT'
         })
         .then(success)
         .catch(failed);

         function success(response) {
            return response;
         }

         function failed(response) {
            return response;
         }
      }

      function get(data) {

         data = data || null;
         return $http({
            url: _url + '/pedido',
            params: data,
            method: 'GET'
         })
         .then(success)
         .catch(failed);

         function success(response) {
            return response;
         }

         function failed(response) {
            return response;
         }
      }
   }
})()
