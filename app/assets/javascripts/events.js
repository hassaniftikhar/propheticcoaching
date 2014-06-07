function moveEvent(event, dayDelta, minuteDelta, allDay) {
  jQuery.ajax({
    data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&all_day=' + allDay + '&authenticity_token=' + authenticity_token,
    dataType: 'script',
    type: 'post',
    url: "/events/" + event.id + "/move"
  });
}

function resizeEvent(event, dayDelta, minuteDelta) {
  jQuery.ajax({
    data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&authenticity_token=' + authenticity_token,
    dataType: 'script',
    type: 'post',
    url: "/events/" + event.id + "/resize"
  });
}

function showEventDetails(event) {
  $('#event_desc').html(event.description);
  $('#edit_event').html("<a href = 'javascript:void(0);' onclick ='editEvent(" + event.id + ")'>Edit</a>");
  if (event.recurring) {
    title = event.title + "(Recurring)";
    $('#delete_event').html("&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete Only This Occurrence</a>");
    $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + true + ")'>Delete All In Series</a>")
    $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", \"future\")'>Delete All Future Events</a>")
  }
  else {
    title = event.title;
    $('#delete_event').html("<a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete</a>");
  }
  $('#desc_dialog').dialog({
    title: title,
    modal: true,
    width: 500,
    draggable: false,
    close: function (event, ui) {
      $('#desc_dialog').dialog('destroy')
    }
  });
}

function editEvent(event_id) {
  console.log("event_id: " + event_id);
  jQuery.ajax({
    url: "/events/" + event_id + "/edit",
    success: function (data) {
      $('#event_desc').html(data['form']);
    }
  });
}

function deleteEvent(event_id, delete_all) {
  jQuery.ajax({
    data: 'authenticity_token=' + authenticity_token + '&delete_all=' + delete_all,
    dataType: 'script',
    type: 'delete',
    url: "/events/" + event_id,
    success: refetch_events_and_close_dialog
  });
}

function refetch_events_and_close_dialog() {
  $('#calendar').fullCalendar('refetchEvents');
  $('.dialog:visible').dialog('destroy');
}

function showPeriodAndFrequency(value) {

  switch (value) {
    case 'Daily':
      $('#period').html('day');
      $('#frequency').show();
      break;
    case 'Weekly':
      $('#period').html('week');
      $('#frequency').show();
      break;
    case 'Monthly':
      $('#period').html('month');
      $('#frequency').show();
      break;
    case 'Yearly':
      $('#period').html('year');
      $('#frequency').show();
      break;

    default:
      $('#frequency').hide();
  }

}

//var $calendar_element = $('#mentee_calendar');

function to_boolean(str) {
  return (str == "true") ? true : false
}

var ready = function () {


  $('#create_event_dialog, #desc_dialog').on('submit', "#event_form", function (event) {
    var $spinner = $('.spinner');
    event.preventDefault();
    $.ajax({
      type: "POST",
      data: $(this).serialize(),
      url: $(this).attr('action'),
      beforeSend: show_spinner,
      complete: hide_spinner,
      success: refetch_events_and_close_dialog,
      error: handle_error
    });

    function show_spinner() {
      $spinner.show();
    }

    function hide_spinner() {
      $spinner.hide();
    }

    function handle_error(xhr) {
      alert(xhr.responseText);
    }
  });

  var renderDialog = function (element, event, event_div_id, dialog_div_id) {
    event.preventDefault();
    var url = element.attr('href');
    $.ajax({
      url: url,
      beforeSend: function () {
        $('#loading').show();
      },
      complete: function () {
        $('#loading').hide();
      },
      success: function (data) {
        $(event_div_id).replaceWith(data['form']);
        $(dialog_div_id).dialog({
          title: 'New Event',
          modal: true,
          width: 500,
          draggable: false,
          close: function (event, ui) {
            $(dialog_div_id).dialog('destroy')
          }
        });
      }
    });
  }

//  $("input#google_event_btn").on("click", function (event) {
//    console.log("=== btn");
////    $("#create_google_event_dialog").dialog('destroy');
//  });

  $("#new_event").on("click", function (event) {
    renderDialog($(this), event, '#create_event', '#create_event_dialog');
  });

  $("#google_event").on("click", function (event) {
    renderDialog($(this), event, '#create_google_event', '#create_google_event_dialog')
  });
  $(".google_event").on("click", function (event) {
    renderDialog($(this), event, '#create_google_event', '#create_google_event_dialog')
  });
}//ready end

$(document).on("page:load", ready);

$(document).ready(ready);
