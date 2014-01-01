//= require active_admin/base
//= require "documentViewer/libs/yepnope.1.5.3-min.js"
//= require "documentViewer/libs/pdfjs/pdf.js"
//= require "documentViewer/libs/pdfjs/compatibility.js"
//= require "documentViewer/ttw-document-viewer.min.js"
//= require jquery_highlight
//= require fullcalendar.min.js
//= require events
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
});