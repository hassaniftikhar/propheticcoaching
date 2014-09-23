//= require active_admin/base
//= require "documentViewer/libs/yepnope.1.5.3-min.js"
//= require "documentViewer/libs/pdfjs/pdf.js"
//= require "documentViewer/libs/pdfjs/compatibility.js"
//= require "documentViewer/ttw-document-viewer.min.js"
//= require jquery_highlight
//= require fullcalendar.min
//= require gcal.js
//= require shared
//= require events
//= require ebooks
//= require meetings.js.coffee
//= require jquery.multiselect


var g_is_updated_time = 0;

function check_session_progress() {
  g_session_event_id = sessionStorage.getItem("session_event_id");
  var g_url = window.location.href;
  // alert("checking");
  if(sessionStorage.getItem("session_event_id") && g_url != sessionStorage.getItem("session_url"))
  {
    // alert("in layout JS2");
    g_start_time = sessionStorage.getItem("session_initial_remaining_time");
    g_session_start_time = new Date(sessionStorage.getItem("session_start_time"));
    g_session_mentee_id = sessionStorage.getItem("session_mentee_id");
    g_session_coach_id = sessionStorage.getItem("session_coach_id");

    g_current_time = new Date();
    g_counter = (g_current_time - g_session_start_time)/1000;
    
    if((g_start_time-g_counter <= 0) && g_is_updated_time == 0)
    {   
      g_is_updated_time = 1; 
      url = "/events/" + g_session_event_id + "/time_slots";
      $.ajax({
        data: 'event_id=' + g_session_event_id + '&time_seconds='+ g_start_time + '&coach_id=' + g_session_coach_id + '&mentee_id=' + g_session_mentee_id ,
        dataType: 'script',  
        type: 'post',
        url: url,
        success: function(){
          sessionStorage.removeItem("session_event_id");
          sessionStorage.removeItem("session_start_time");
          sessionStorage.removeItem("session_initial_remaining_time")
          sessionStorage.removeItem("session_mentee_id");
          sessionStorage.removeItem("session_coach_id");
          sessionStorage.removeItem("session_url");
          alert("Current Session is Timeout");
        }
        ,
        error: function(){
          sessionStorage.removeItem("session_event_id");
          sessionStorage.removeItem("session_start_time");
          sessionStorage.removeItem("session_initial_remaining_time")
          sessionStorage.removeItem("session_mentee_id");
          sessionStorage.removeItem("session_coach_id");
          sessionStorage.removeItem("session_url");
          alert("Current Session is Timeout");
        }
      });
}
}
} 

$(document).ready(function () {
  window.setInterval(check_session_progress, 10000);
  $("#search_ebook").on("ajax:success",function (e, data, status, xhr) {
    console.log("search ebook success");
    // disable following line. Now date is refresh through _search_result.js in views/admin/ebooks
    // $("#result_table").html(xhr.responseText);
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


$("#categories_list").multiselect({
  selectedList: 4, 
  header: "Category Selection",
  noneSelectedText: "Select Category",
  click: function(event, ui){
        // $callback.text(ui.value + ' ' + (ui.checked ? 'checked' : 'unchecked') );
        var url = window.location.href;
        var parts = url.split("/");
        var resource_id = parts[parts.length - 2];
        console.log("event: " + event);
        // var url = '/admin/activities'+( ( activity_id > 0 ) ? ('/'+activity_id+'/assign_multiple_categories'):'/batch_assign_multiple_categories');
        var url = '/admin/'+( ( resource_id > 0 ) ? (parts[parts.length - 3]+'/'+resource_id+'/assign_multiple_categories'):parts[parts.length - 2]+'/batch_assign_multiple_categories');
        

        switch(resource_id > 0 ? parts[parts.length - 3]:parts[parts.length - 2]) {
          case 'ebooks':
          var selection = ebook_selection;
          var redirection_path = '/admin/ebooks';
          break;
          case 'activities':
          var selection = activity_selection;
                // redirection_path = '/admin/activities?message=true';
                var redirection_path = '/admin/activities';
                break;
                case 'questions':
                var selection = question_selection;
                var redirection_path = '/admin/questions';
                break;
                case 'exercises':
                var selection = exercise_selection;
                var redirection_path = '/admin/exercises';
                break;
                default:
                var selection = ebook_selection;
                var redirection_path = '/admin/ebooks';
              }

              $.ajax({
                data: 'category_id=' + ui.value + '&resource_selection=' + selection + '&checked=' + (ui.checked ? 'checked' : 'unchecked'),
                dataType: 'script',
                type: 'post',
                url: url,
                success: function(){
                  if( resource_id > 0 ) {
                    location.reload();
                  }
                  else {
                    window.location.href = redirection_path;
                  }
            // location.reload();
            // window.location.href = '/admin/activities?message=true';
            // $("#activity_list").html("success testing");
          }
          ,
          error: function(){
            if( resource_id > 0 ) {
              location.reload();
            }
            else {
              window.location.href = redirection_path;
            }



            // location.reload();
            // window.location = window.location.href;
            // window.location.href = window.location.protocol +url+ window.location.host + window.location.pathname;
            // window.location.href = url
            // window.location.replace(window.location.href);
            // window.location.assign(document.URL);
            // window.location.href = '/admin/activities?message=true';
            // $("#activity_list").html("fail testing");
            // $("#activity_list").reload;
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



$(".booklink").click(function () {
  var document_id = $(this).text();
    // var url =  document_id + "/pdf.pdf";
    var url = "/ebooks/" + document_id + "/pdf.pdf";
    var currentPage = 1 ;
    var documentViewer = $('#pdfContainer').documentViewer(
    {
      path: "/assets/documentViewer/",
      width: 800,
      debug: true
    }
    );
    documentViewer.load(url, {currentPage: currentPage});
    $("#pdfContainer").dialog({
      close: function (event, ui) {
        $(this).empty().dialog('destroy');
      },
      width: 900
    });
    
  });



});