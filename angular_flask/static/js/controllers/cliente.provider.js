(function() {
  'use strict'

  angular
    .module('Cliente')
    .provider('Cliente', ClienteProvider)

  function ClienteProvider() {
    var _url = 'http://localhost:5000/'

    this.setUrl = function(url) {
      if (typeof url == 'string')
        _url = url;
    }

    this.$get = function() {
      return {
        urlBase: _url,
        producao: true
      }
    }
  }
})()
