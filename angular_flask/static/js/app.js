(function() {
   'use strict';

   angular
      .module('Fluffy', ['ngRoute', 'ngResource', 'xeditable', 'ui.bootstrap',
         'ngDragDrop', 'angularMoment', 'mwl.calendar', 'Index', 'Cliente',
         'Funcao', 'Permissao', 'RedeSocial', 'GrupoItem', 'Servico', 'Consulta', 'Lembrete',
         'Estoque', 'Venda', 'Estatisticas'
      ])
      .config(['$routeProvider', '$locationProvider', '$httpProvider', 'calendarConfig',
         function($routeProvider, $locationProvider, $httpProvider, calendarConfig) {
            $httpProvider.defaults.cache = false;
            $httpProvider.defaults.headers.post["Content-Type"] = "application/json";
            $httpProvider.defaults.headers.put["Content-Type"] = "application/json";
            $locationProvider.html5Mode(true);
            $routeProvider
               .when('/', {
                  templateUrl: '../static/partials/overview.html',
                  controller: 'IndexController',
                  controllerAs: 'Index'
               })
               .otherwise({
                  redirectTo: '/'
               });
           console.log(calendarConfig);
           // calendarConfig.templates.calendarMonthView = 'path/to/custom/template.html'; //change the month view template globally to a custom template
           // calendarConfig.dateFormatter = 'moment'; //use either moment or angular to format dates on the calendar. Default angular. Setting this will override any date formats you have already set.
           // calendarConfig.allDateFormats.moment.date.hour = 'HH:mm'; //this will configure times on the day view to display in 24 hour format rather than the default of 12 hour
           // calendarConfig.allDateFormats.moment.title.day = 'ddd D MMM'; //this will configure the day view title to be shorter
           // calendarConfig.i18nStrings.weekNumber = 'Week {week}'; //This will set the week number hover label on the month view
           // calendarConfig.displayAllMonthEvents = true; //This will display all events on a month view even if they're not in the current month. Default false.calendarConfig.showTimesOnWeekView = true; //Make the week view more like the day view, with the caveat that event end times are ignored.
         }
      ])
      .run(function(editableOptions) {
         editableOptions.theme = 'bs3';
      });
})()
