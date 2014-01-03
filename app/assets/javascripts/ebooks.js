$(document).ready(function () {


  PrivatePub.subscribe("/ebooks", function (data, channel) {
    var val = jQuery.parseJSON(data.message);
    $("#chat_div").chatbox("option", "boxManager").addMsg("Mr. Foo", val['message']);
  });

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

});
