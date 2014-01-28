//= require active_admin/base
//= require "documentViewer/libs/yepnope.1.5.3-min.js"
//= require "documentViewer/libs/pdfjs/pdf.js"
//= require "documentViewer/libs/pdfjs/compatibility.js"
//= require "documentViewer/ttw-document-viewer.min.js"
//= require jquery_highlight
//= require fullcalendar.min.js
//= require gcal.js
//= require events
//= require private_pub
//= require ebooks


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
});