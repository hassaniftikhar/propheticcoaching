$(document).ready(function(){

  $("td#tags").highlight($("input#query").val());

  function embedPDF(){
    var myPDF = new PDFObject({
      url: 'http://jquery.malsup.com/media/guice.pdf',
      pdfOpenParams: { page: '5', search: 'Java' }
    }).embed("");
  }
//  window.onload = embedPDF;
//  var url = 'http://localhost:3000/guice.pdf';
  var documentViewer = $('#pdfContainer').documentViewer(
      {
        path: "/assets/documentViewer/",
        debug:true
      }
  );

  $("td #pdf-view").click(function() {
    var document_id = $(this).closest('td').prev('td').prev('td').text(),
        url = "/ebooks/"+document_id+"/pdf.pdf",
        currentPage = parseInt($(this).text());
    console.log(document_id);
    console.log(currentPage);
    documentViewer.load(url, {currentPage: currentPage});
  });
// Disable workers to avoid yet another cross-origin issue (workers need the URL of
// the script to be loaded, and dynamically loading a cross-origin script does
// not work)
//
//  PDFJS.disableWorker = true;
//
////
//// Asynchronous download PDF as an ArrayBuffer
////
//  console.log("before getdoc");
//  PDFJS.getDocument(url).then(function getPdfHelloWorld(pdf) {
//    console.log("in before getdoc");
//    //
//    // Fetch the first page
//    //
//    pdf.getPage(1).then(function getPageHelloWorld(page) {
//      var scale = 1.5;
//      var viewport = page.getViewport(scale);
//
//      //
//      // Prepare canvas using PDF page dimensions
//      //
//      var canvas = document.getElementById('the-canvas');
//      var context = canvas.getContext('2d');
//      canvas.height = viewport.height;
//      canvas.width = viewport.width;
//
//      //
//      // Render PDF page into canvas context
//      //
//      page.render({canvasContext: context, viewport: viewport});
//    });
//  });
//  console.log("after getdoc");
//
////  PDFJS.getDocument(url);
//
});
