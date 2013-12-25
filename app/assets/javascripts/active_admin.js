//= require active_admin/base
//= require "documentViewer/libs/yepnope.1.5.3-min.js"
//= require "documentViewer/libs/pdfjs/pdf.js"
//= require "documentViewer/libs/pdfjs/compatibility.js"
//= require "documentViewer/ttw-document-viewer.min.js"
//= require jquery_highlight



$(document).ready(function() {
  return $("#search_ebook").on("ajax:success", function(e, data, status, xhr) {
    console.log("search ebook success");

    $("#result_table").html(xhr.responseText);
    $("td#tags").highlight($("input#query").val());
    $('#pdfContainer').empty();
    var documentViewer = $('#pdfContainer').documentViewer(
        {
          path: "http://localhost:3000/assets/documentViewer/",
          debug:true
        }
    );

    $("td #pdf-view").click(function() {
      var document_id = $(this).closest('td').prev('td').prev('td').text(),
          url = "http://localhost:3000/ebooks/"+document_id+"/pdf.pdf",
          currentPage = parseInt($(this).text());
      console.log(document_id);
      console.log(currentPage);
      documentViewer.load(url, {currentPage: currentPage});
    });

  }).bind("ajax:error", function(e, xhr, status, error) {
        console.log("search ebook error");
        return $("#search_ebook").append("<p>ERROR</p>");
      });



});