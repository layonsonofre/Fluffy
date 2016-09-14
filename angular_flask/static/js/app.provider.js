(function() {
  'use strict'

  angular
    .module('Fluffy')
    .provider('Fluffy', FluffyProvider)

  function FluffyProvider() {
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
