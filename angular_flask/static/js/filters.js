'use strict';

angular.module('angularFlaskFilters', []).filter('uppercase', function() {
	return function(input) {
		return input.toUpperCase();
	}
});
