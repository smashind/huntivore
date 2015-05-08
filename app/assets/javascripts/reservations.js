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
          var reservation_from = (Date.parse($("#reservation_from").val())) / 86400000;
          $(".res_from").text($("#reservation_from").val());
          var users = parseInt($("#selectUsers").val());
          if (hunttype == "Day trip") {
            if (per_person == true) {
              $(".users").text(users);
              $(".price").text(((price * users) * fee) + price * users);
              $(".trip-preview").slideDown();
            } else { 
              $(".users").text(users);
              $(".price").text((price * fee) + price);
              $(".trip-preview").slideDown();
            };
          } else {
            if ($("#reservation_to").val().length) {
              var reservation_to = (Date.parse($("#reservation_to").val())) / 86400000;
              $(".res_to").text($("#reservation_to").val());
              $(".days").text(reservation_to - reservation_from);
              var users = parseInt($("#selectUsers").val());
              if (per_person == true) {
                $(".users").text(users);
                $(".price").text((((reservation_to - reservation_from).toFixed(0) * price * users) * fee) + (reservation_to - reservation_from).toFixed(0) * price * users);
                $(".trip-preview").slideDown();
              } else { 
                $(".users").text(users);
                $(".price").text((((reservation_to - reservation_from).toFixed(0) * price) * fee) + (reservation_to - reservation_from).toFixed(0) * price);
                $(".trip-preview").slideDown();
              };
            };
          };
      }
  },datepickersOpt));

  $("#reservation_to").datepicker($.extend({
      onSelect: function() {
          var maxDate = $(this).datepicker('getDate');
          maxDate.setDate(maxDate.getDate()-1);
          $("#reservation_from").datepicker( "option", "maxDate", maxDate);
          var reservation_from = (Date.parse($("#reservation_from").val())) / 86400000;
          $(".res_from").text($("#reservation_from").val());
          var reservation_to = (Date.parse($("#reservation_to").val())) / 86400000;
          $(".res_to").text($("#reservation_to").val());
          $(".days").text((reservation_to - reservation_from).toFixed(0));
          var users = parseInt($("#selectUsers").val());
          if (per_person == true) {
            $(".users").text(users);
            $(".price").text((((reservation_to - reservation_from).toFixed(0) * price * users) * fee) + (reservation_to - reservation_from).toFixed(0) * price * users);
            $(".trip-preview").slideDown();
          } else { 
            $(".users").text(users);
            $(".price").text((((reservation_to - reservation_from).toFixed(0) * price) * fee) + (reservation_to - reservation_from).toFixed(0) * price);
            $(".trip-preview").slideDown();
          };
      }
  },datepickersOpt));

  if (hunttype == "Day trip") {
    $("#selectUsers").change(function(e) {  
      if ($("#reservation_from").val().length) {
        var reservation_from = (Date.parse($("#reservation_from").val())) / 86400000;
        $(".res_from").text($("#reservation_from").val());
        var users = parseInt($("#selectUsers").val());
        if (per_person == true) {
          $(".users").text(users);
          $(".price").text(((price * users) * fee) + price * users);
          $(".trip-preview").slideDown();
        } else { 
          $(".users").text(users);
          $(".price").text((price * fee) + price);
          $(".trip-preview").slideDown();
        }
      }
    }).change();
  }

  if (hunttype == "Overnight") {
    $("#selectUsers").change(function(e) {
      if ($("#reservation_to").val().length) {
        var reservation_from = (Date.parse($("#reservation_from").val())) / 86400000;
        $(".res_from").text($("#reservation_from").val())
        var reservation_to = (Date.parse($("#reservation_to").val())) / 86400000;
        $(".res_to").text($("#reservation_to").val());
        $(".days").text(reservation_to - reservation_from);
        var users = parseInt($("#selectUsers").val());
        if (per_person == true) {             
          $(".users").text(users);
          $(".price").text((((reservation_to - reservation_from).toFixed(0) * price * users) * fee) + (reservation_to - reservation_from).toFixed(0) * price * users);
          $(".trip-preview").slideDown();
        } else { 
          $(".users").text(users);
          $(".price").text((((reservation_to - reservation_from).toFixed(0) * price) * fee) + (reservation_to - reservation_from).toFixed(0) * price);
          $(".trip-preview").slideDown();
        }
      } else if ($("#reservation_to").val().length && $("#reservation_from").val().length) {
        var reservation_from = (Date.parse($("#reservation_from").val())) / 86400000;
        $(".res_from").text($("#reservation_from").val());
        var reservation_to = (Date.parse($("#reservation_to").val())) / 86400000;
        $(".res_to").text($("#reservation_to").val());
        $(".days").text(reservation_to - reservation_from);
        var users = parseInt($("#selectUsers").val());
        if (per_person == true) {
          $(".users").text(users);
          $(".price").text((((reservation_to - reservation_from).toFixed(0) * price * users) * fee) + (reservation_to - reservation_from).toFixed(0) * price * users);
          $(".trip-preview").slideDown();
        } else { 
          $(".users").text(users);
          $(".price").text((((reservation_to - reservation_from).toFixed(0) * price) * fee) + (reservation_to - reservation_from).toFixed(0) * price);
          $(".trip-preview").slideDown();
        }
      }
    }).change();
  }
});