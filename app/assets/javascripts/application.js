// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require tether
//= require bootstrap-sprockets
//= require js-routes
//= require_tree .
// <!-- BEGIN CORE PLUGINS -->
//= require metronic/global/plugins/js.cookie.min
//= require metronic/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min
//= require metronic/global/plugins/jquery-slimscroll/jquery.slimscroll.min
//= require metronic/global/plugins/jquery.blockui.min
//= require metronic/global/plugins/uniform/jquery.uniform.min
//= require metronic/global/plugins/bootstrap-switch/js/bootstrap-switch.min
// <!-- END CORE PLUGINS -->
// <!-- BEGIN PAGE LEVEL PLUGINS -->
//= require metronic/global/plugins/moment.min
//= require metronic/global/plugins/bootstrap-daterangepicker/daterangepicker.min
//= require metronic/global/plugins/morris/morris.min
//= require metronic/global/plugins/morris/raphael-min
//= require metronic/global/plugins/counterup/jquery.waypoints.min
//= require metronic/global/plugins/counterup/jquery.counterup.min
//= require metronic/global/plugins/fullcalendar/fullcalendar.min
//= require metronic/global/plugins/flot/jquery.flot.min
//= require metronic/global/plugins/flot/jquery.flot.resize.min
//= require metronic/global/plugins/flot/jquery.flot.categories.min
//= require metronic/global/plugins/jquery-easypiechart/jquery.easypiechart.min
//= require metronic/global/plugins/jquery.sparkline.min
//! require metronic/global/plugins/jqvmap/jqvmap/jquery.vmap
//! require metronic/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.russia
//! require metronic/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.world
//! require metronic/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.europe
//! require metronic/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.germany
//! require metronic/global/plugins/jqvmap/jqvmap/maps/jquery.vmap.usa
//! require metronic/global/plugins/jqvmap/jqvmap/data/jquery.vmap.sampledata
// <!-- END PAGE LEVEL PLUGINS -->
// <!-- BEGIN THEME GLOBAL SCRIPTS -->
//= require metronic/global/scripts/app.min
// <!-- END THEME GLOBAL SCRIPTS -->
// <!-- BEGIN PAGE LEVEL SCRIPTS -->
//= require metronic/pages/scripts/dashboard.min
// <!-- END PAGE LEVEL SCRIPTS -->
// <!-- BEGIN THEME LAYOUT SCRIPTS -->
//= require metronic/layouts/layout3/scripts/layout.min
//= require metronic/layouts/layout3/scripts/demo.min
//= require metronic/layouts/global/scripts/quick-sidebar.min
// <!-- END THEME LAYOUT SCRIPTS -->

jQuery(document).ready(function() {
    App.init(); // init metronic core componets
    Layout.init(); // init layout
    QuickSidebar.init() // init quick sidebar
    // Index.init();
    // Index.initDashboardDaterange();
    // Index.initJQVMAP(); // init index page's custom scripts
    // Index.initCalendar(); // init index page's custom scripts
    // Index.initCharts(); // init index page's custom scripts
    // Index.initChat();
    // Index.initMiniCharts();
    // Index.initIntro();
    // Tasks.initDashboardWidget();
});
