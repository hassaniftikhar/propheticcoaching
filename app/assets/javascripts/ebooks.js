$(document).ready(function () {

  $(".container .row").on("click", "td #pdf-view", function () {
    var documentViewer = $('#pdfContainer').documentViewer(
        {
          path: "/assets/documentViewer/",
          width: 800,
          debug: true
        }
    );

    var document_id = $(this).closest('td').prev('td').prev('td').text(),
        url = "/ebooks/" + document_id + "/pdf.pdf",
        currentPage = parseInt($(this).text());
    console.log(document_id);
    console.log(currentPage);


    documentViewer.load(url, {currentPage: currentPage});
    $("#pdfContainer").dialog({
      close: function(event, ui) {
        $(this).empty().dialog('destroy');
      },
      width:900
    });

  });

  $("td#tags").highlight($("input#query").val());

});
