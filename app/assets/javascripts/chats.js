ready = function () {

  var user_name = $("#chat_div").attr("user_name");
  var user_id = $("#chat_div").attr("user_id");

  PrivatePub.subscribe("/chats/talk", function (data, channel) {
    var val = jQuery.parseJSON(data.message);

    $("#chat_div").chatbox("option", "boxManager").addMsg(val['user_name'], val['message']);
  });

  if (user_name.length > 0) {
    $("#chat_div").chatbox({id: "chat_div", title: "Public Chat Room", offset: 10, width: 200,
      messageSent: function (id, user, msg) {

        $.ajax({
          data: 'chat[message]=' + msg,
          type: "POST",
          url: "/chats",
          success: function (data) {
            console.log("successfully posted the chat");
          }
        });

      }
    });
  }

};

$(document).ready(ready);
$(document).on("page:load", ready);