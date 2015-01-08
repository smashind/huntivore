// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui
//= require_tree .


// $(function() {
// 	$("#reservation_from").datepicker({ minDate: 0 });
// 	$("#reservation_to").datepicker({ minDate:  });
// })

$(function() {

    var datepickersOpt = {
        dateFormat: 'mm/dd/yy',
        minDate   : 0
    }

    $("#reservation_from").datepicker($.extend({
        onSelect: function() {
        	  $("#reservation_to").removeAttr('disabled');
            var minDate = $(this).datepicker('getDate');
            minDate.setDate(minDate.getDate()+1); //add one day
            $("#reservation_to").datepicker( "option", "minDate", minDate);
        }
    },datepickersOpt));

    $("#reservation_to").datepicker($.extend({
        onSelect: function() {
            var maxDate = $(this).datepicker('getDate');
            maxDate.setDate(maxDate.getDate()-1);
            $("#reservation_from").datepicker( "option", "maxDate", maxDate);
        }
    },datepickersOpt));
	
});

$(document).ready(function() {
    $('.popup-gallery').magnificPopup({
        delegate: 'a',
        type: 'image',
        tLoading: 'Loading image #%curr%...',
        mainClass: 'mfp-img-mobile',
        gallery: {
            enabled: true,
            navigateByImgClick: true,
            preload: [0,1] // Will preload 0 - before current, and 1 after the current image
        },
        image: {
            tError: '<a href="%url%">The image #%curr%</a> could not be loaded.',
            // titleSrc: function(item) {
            //     return item.el.attr('title') + '<small>by Marsel Van Oosten</small>';
            // }
        }
    });
});