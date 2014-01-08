ready = function () {

  var user_name = $("#chat_div").attr("user_name");
  var my_id = $("#chat_div").attr("user_id");

  PrivatePub.subscribe("/chats/talk", function (data, channel) {
    var val = jQuery.parseJSON(data.message);

    if (val['id'] == "client_list") {
      //update online client list
      console.log("online clients recvd: building divs");
      var clients = jQuery.parseJSON(val['message']);
      $("#online_contacts").empty();

      for (var i = 0; i < clients.length; i++) {
        var user_info = clients[i].split("_");
        var client_id = user_info[user_info.length - 1];
        var client_name = "";

        for (var j = 0; j < (user_info.length - 1); j++) {
          client_name += user_info[j];
          client_name += " ";
        }

        if (client_id != my_id) {
          var html = "<div class='contact' id='contact_" + client_id + "'>" + client_name + "</div>";
          $("#online_contacts").append(html);
        }
      }
    } else if (val['dest']) {
      //destination user message
      console.log("val['dest']: " + val['dest']);
      var dest_id = "contact_" + val['src']; //as we have to open src id windown at dest
      if (val['src'] != my_id && val['dest'] == my_id) {
        dest_id = createChatWindow(dest_id, val['user_name']);
        $("#" + dest_id).chatbox("option", "boxManager").addMsg(val['user_name'], val['message']);
      }
    } else {
      //public chat message
      console.log("--- else ---");
      $("#chat_div").chatbox("option", "boxManager").addMsg(val['user_name'], val['message']);
    }
  });

  $("#chat_div").chatbox({id: "chat_div", title: "Public Chat Room", offset: 5, width: 200,
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
  $("#chat_div").parent().hide();

  var counter = 0;
  var idList = new Array();

  var broadcastMessageCallback = function (from, msg, id) {
    console.log("broadcastMessageCallback, from:" + from + " msg:" + msg + " id: " + id);
    for (var i = 0; i < idList.length; i++) {
      chatboxManager.addBox(idList[i]);
      $("#" + idList[i]).chatbox("option", "boxManager").addMsg(from, msg);
    }
  }

  var messageCallback = function (dest, msg, id) {

    var div_info = id.split("_");
    var dest_user_id = div_info[div_info.length - 1];

    $("#" + id).chatbox("option", "boxManager").addMsg("me", msg);

    console.log("messageCallback " + dest + " " + dest_user_id);
    $.ajax({
      data: 'chat[message]=' + msg + '&dest=' + dest_user_id + '&src=' + my_id,
      type: "POST",
      url: "/chats",
      success: function (data) {
        console.log("successfully posted the chat");
      }
    });
  }

//  chatboxManager.init({messageSent: broadcastMessageCallback});
  chatboxManager.init({messageSent: messageCallback});

  $("#chat-main").on("click", ".contact", function (event) {

    createChatWindow($(this).attr('id'), $(this).text());

  });

  var createChatWindow = function (id, text) {

    console.log("=== createChatWin === div: " + id);

    var div_id = "box" + id;
    var user_name = text;

    console.log(div_id);

    if ($("#" + div_id).length == 0) {
      idList.push(div_id);
      chatboxManager.addBox(div_id,
          {
            dest: "dest" + id, // not used in demo
            title: "box" + id,
            first_name: user_name,
            last_name: ""
            //you can add your own options too
          });
      event.preventDefault();
    }
    return div_id;
  }

};

$(document).ready(ready);
$(document).on("page:load", ready);


// Need this to make IE happy
// see http://soledadpenades.com/2007/05/17/arrayindexof-in-internet-explorer/
if (!Array.indexOf) {
  Array.prototype.indexOf = function (obj) {
    for (var i = 0; i < this.length; i++) {
      if (this[i] == obj) {
        return i;
      }
    }
    return -1;
  }
}


var chatboxManager = function () {

  // list of all opened boxes
  var boxList = new Array();
  // list of boxes shown on the page
  var showList = new Array();
  // list of first names, for in-page demo
  var nameList = new Array();

  var config = {
    width: 200, //px
    gap: 20,
    maxBoxes: 5,
    messageSent: function (dest, msg, id) {
      // override this
      $("#" + dest).chatbox("option", "boxManager").addMsg(dest, msg);
    }
  };

  var init = function (options) {
    $.extend(config, options)
  };


  var delBox = function (id) {
    // TODO
  };

  var getNextOffset = function () {
    return (config.width + config.gap) * (showList.length + 1);
  };

  var boxClosedCallback = function (id) {
    // close button in the titlebar is clicked
    var idx = showList.indexOf(id);
    if (idx != -1) {
      showList.splice(idx, 1);
      diff = config.width + config.gap;
      for (var i = idx; i < showList.length; i++) {
        offset = $("#" + showList[i]).chatbox("option", "offset");
        $("#" + showList[i]).chatbox("option", "offset", offset - diff);
      }
    }
    else {
      alert("should not happen: " + id);
    }
  };

  // caller should guarantee the uniqueness of id
  var addBox = function (id, user, name) {
    var idx1 = showList.indexOf(id);
    var idx2 = boxList.indexOf(id);
    if (idx1 != -1) {
      // found one in show box, do nothing
    }
    else if (idx2 != -1) {
      // exists, but hidden
      // show it and put it back to showList
      $("#" + id).chatbox("option", "offset", getNextOffset());
      var manager = $("#" + id).chatbox("option", "boxManager");
      manager.toggleBox();
      showList.push(id);
    }
    else {
      var el = document.createElement('div');
      el.setAttribute('id', id);
      $(el).chatbox({id: id,
        user: user,
        title: user.first_name + " " + user.last_name,
        hidden: false,
        width: config.width,
        offset: getNextOffset(),
        messageSent: messageSentCallback,
        boxClosed: boxClosedCallback
      });
      boxList.push(id);
      showList.push(id);
      nameList.push(user.first_name);
    }
  };

  var messageSentCallback = function (id, user, msg) {
    var idx = boxList.indexOf(id);
    console.log("id: " + id + " idx: " + idx);
    config.messageSent(nameList[idx], msg, id);
  };

  // not used in demo
  var dispatch = function (id, user, msg) {
    $("#" + id).chatbox("option", "boxManager").addMsg(user.first_name, msg);
  }

  return {
    init: init,
    addBox: addBox,
    delBox: delBox,
    dispatch: dispatch
  };
}();