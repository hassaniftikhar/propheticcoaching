$(document).ready(function () {

  $(".container .row").on("click", "td #pdf-view", function () {

    if ($("#pdfContainer").hasClass('ui-dialog-content')) {
      $('#pdfContainer').empty().dialog('destroy');
    }

    var document_id = $(this).closest('td').prev('td').prev('td').text();
    var url = "/ebooks/" + document_id + "/pdf.pdf";
    var currentPage = parseInt($(this).text());
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

  $("td#tags").highlight($("input#query").val());
  $("td#question_body").highlight($("input#question_query").val());
  $("td#activity_body").highlight($("input#query").val());
  $("td#exercise_body").highlight($("input#query").val());



  $(".container .row").on("click", "td #pdf-fullview", function () {

    if ($("#pdfContainer").hasClass('ui-dialog-content')) {
      $('#pdfContainer').empty().dialog('destroy');
    }

    var document_id = $(this).closest('td').text();
    var url =  document_id + "/pdf.pdf";
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
