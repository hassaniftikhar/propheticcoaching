// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.10.3.custom.min.js
//= require twitter/bootstrap
//= require turbolinks
//= require "documentViewer/libs/yepnope.1.5.3-min.js"
//= require "documentViewer/libs/pdfjs/pdf.js"
//= require "documentViewer/libs/pdfjs/compatibility.js"
//= require "documentViewer/ttw-document-viewer.min.js"
//= require jquery_highlight
//= require private_pub
//= require ebooks
//= require events
//= require active_admin
//= require bootstrap
//= require private_pub
//= require jquery.ui.chatbox


ready = function () {
  $("#chat_div").chatbox({id: "chat_div", title: "Public Chat Room", offset: 10, width: 200,
      messageSent: function (id, user, msg) {
        this.boxManager.addMsg(user, msg);
//        publish_to("/ebooks", msg);
      }
    });

};
$(document).ready(ready);
$(document).on("page:load", ready);