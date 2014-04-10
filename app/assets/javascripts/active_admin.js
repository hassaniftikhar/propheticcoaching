//= require active_admin/base
//= require "documentViewer/libs/yepnope.1.5.3-min.js"
//= require "documentViewer/libs/pdfjs/pdf.js"
//= require "documentViewer/libs/pdfjs/compatibility.js"
//= require "documentViewer/ttw-document-viewer.min.js"
//= require jquery_highlight
//= require fullcalendar.min.js
//= require gcal.js
//= require events
//= require ebooks
//= require meetings.js.coffee
//= require jquery.multiselect


$(document).ready(function () {
  $("#search_ebook").on("ajax:success",function (e, data, status, xhr) {

    console.log("search ebook success");
    $("#result_table").html(xhr.responseText);
    $("td#tags").highlight($("input#query").val());

  }).bind("ajax:error", function (e, xhr, status, error) {
        console.log("search ebook error");
        return $("#search_ebook").append("<p>ERROR</p>");
  });

  $("#main_content").on("click", "#show_calendar", function(){
    $("#calendar").show();
    $("#calendar").dialog({
      width:700
    });
    $("#calendar .fc-button.fc-button-month.fc-state-default.fc-corner-left").trigger("click");
  });

  $("#main_content").on("click", "#btn_ebook_search", function(){
    $("#ebook_search #result_table tbody").empty();
    $("#ebook_search").show();
    $("#ebook_search").dialog({
      width:800
    });
  });

  var $callback = $("#callback");
  $("#coaches_list").multiselect({
    selectedList: 4, 
    header: "Coach Selection",
     click: function(event, ui){
        // $callback.text(ui.value + ' ' + (ui.checked ? 'checked' : 'unchecked') );
        var url = window.location.href;
        var parts = url.split("/");
        var mentee_id = parts[parts.length - 2];

        console.log("event: " + event);

        var url = '/admin/mentees'+( ( mentee_id > 0 ) ? ('/'+mentee_id+'/assign_multiple_coaches'):'/batch_assign_multiple_coaches');

        $.ajax({
          data: 'coach_id=' + ui.value + '&mentee_selection=' + mentee_selection + '&checked=' + (ui.checked ? 'checked' : 'unchecked'),
          dataType: 'script',
          type: 'post',
          url: url,
          success: function(){
            location.reload();
          }
          ,
          error: function(){
            location.reload();
          }
        });
        // return false;
     },
     beforeopen: function(){
        $callback.text("Select about to be opened...");
     },
     open: function(){
        $callback.text("Select opened!");
     },
     beforeclose: function(){
        $callback.text("Select about to be closed...");
     },
     close: function(){
        $callback.text("Select closed!");
     },
     checkAll: function(){
        $callback.text("Check all clicked!");
     },
     uncheckAll: function(){
        $callback.text("Uncheck all clicked!");
     },
     optgrouptoggle: function(event, ui){
        var values = $.map(ui.inputs, function(checkbox){
           return checkbox.value;
        }).join(", ");
        
        $callback.html("Checkboxes " + (ui.checked ? "checked" : "unchecked") + ": " + values);
     }
  });


// ----------------------------------------------------------------
  // var $callback = $("#callback");
  // $("#coach_list").multiselect({
  //   multiple: false,
  //   header: "Coach Selection",
  //   noneSelectedText: "Select a Coach",
  //   selectedList: 1,
  //    click: function(event, ui){
  //       // $callback.text(ui.value + ' ' + (ui.checked ? 'checked' : 'unchecked') );

  //       console.log("event: " + event);

  //       var url = '/admin/events'+( ( event_id > 0 ) ? ('/'+event_id+'/assign_multiple_coaches'):'/batch_assign_multiple_coaches');

  //       // return false;
  //    },
  //    beforeopen: function(){
  //       $callback.text("Select about to be opened...");
  //    },
  //    open: function(){
  //       $callback.text("Select opened!");
  //    },
  //    beforeclose: function(){
  //       $callback.text("Select about to be closed...");
  //       var values = $("#coach_list").val();
  //       alert(values);
  //    },
  //    close: function(){
  //       $callback.text("Select closed!");
  //    },
  //    checkAll: function(){
  //       $callback.text("Check all clicked!");
  //    },
  //    uncheckAll: function(){
  //       $callback.text("Uncheck all clicked!");
  //    },
  //    optgrouptoggle: function(event, ui){
  //       var values = $.map(ui.inputs, function(checkbox){
  //          return checkbox.value;
  //       }).join(", ");
        
  //       $callback.html("Checkboxes " + (ui.checked ? "checked" : "unchecked") + ": " + values);
  //    }
  // });
  // var value = $("#coaches_list").val();
  // alert(value);


  function editEvent(event_id) {
    console.log("event_id: " + event_id);
    alert(event_id);
    jQuery.ajax({
      url: "/events/" + event_id + "/edit",
      success: function (data) {
        $('#event_desc').html(data['form']);
      }
    });
  }

});