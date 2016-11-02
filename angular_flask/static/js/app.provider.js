(function() {
  'use strict'

  angular
    .module('Fluffy')
    .provider('Fluffy', FluffyProvider);

  function FluffyProvider() {
    // var _url = 'http://ec2-52-67-160-63.sa-east-1.compute.amazonaws.com:5000';
    var _url = 'http://localhost:5000/api';

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
