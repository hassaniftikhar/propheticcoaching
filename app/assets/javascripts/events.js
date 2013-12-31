
$('#new_event').click(function (event) {
  event.preventDefault();
  var url = $(this).attr('href');
  $.ajax({
    url: url,
    beforeSend: function () {
      $('#loading').show();
    },
    complete: function () {
      $('#loading').hide();
    },
    success: function (data) {
      $('#create_event').replaceWith(data['form']);
      $('#create_event_dialog').dialog({
        title: 'New Event',
        modal: true,
        width: 500,
        close: function (event, ui) {
          $('#create_event_dialog').dialog('destroy')
        }
      });
    }
  });
});

function moveEvent(event, dayDelta, minuteDelta, allDay){
  jQuery.ajax({
    data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&all_day=' + allDay + '&authenticity_token=' + authenticity_token,
    dataType: 'script',
    type: 'post',
    url: "/mentees/"+event.id+"/events/move"
  });
}

function resizeEvent(event, dayDelta, minuteDelta){
  jQuery.ajax({
    data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&authenticity_token=' + authenticity_token,
    dataType: 'script',
    type: 'post',
    url: "/mentees/"+event.id+"/events/resize"
  });
}

function showEventDetails(event){
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
    close: function(event, ui){
      $('#desc_dialog').dialog('destroy')
    }
  });
}

function get_mentee_id() {
  return $('#calendar').attr('mentee_id');
//  return $('#calendar').data().mentee_id;
}

function editEvent(event_id){
  var mentee_id = get_mentee_id();
  console.log("event_id: "+mentee_id+" event_id: "+event_id );
  jQuery.ajax({
    url: "/mentees/"+mentee_id+"/events/" + event_id + "/edit",
    success: function(data) {
      $('#event_desc').html(data['form']);
    }
  });
}

function deleteEvent(event_id, delete_all){
  var mentee_id = get_mentee_id();
  jQuery.ajax({
    data: 'authenticity_token=' + authenticity_token + '&delete_all=' + delete_all,
    dataType: 'script',
    type: 'delete',
    url: "/mentees/" + mentee_id + "/events/" + event_id,
    success: refetch_events_and_close_dialog
  });
}

function refetch_events_and_close_dialog() {
  $('#calendar').fullCalendar( 'refetchEvents' );
  $('.dialog:visible').dialog('destroy');
}

function showPeriodAndFrequency(value){

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

var ready = function() {
  console.log("doc . ready function called");
  var mentee_id = get_mentee_id();
  var events_url;
  if(mentee_id) {
    console.log(" mentee id available ");
    events_url = "/mentees/"+mentee_id+"/events/get_events";
  }
  else {
    console.log(" mentee id NOT available ");
    events_url = "/events/get_events";
  }

  if($('#calendar').length > 0) {
//    alert(calendar_editable);
    var editable = to_boolean(calendar_editable);
    $('#calendar').fullCalendar({
      editable: editable,
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      defaultView: 'agendaWeek',
      height: 500,
      slotMinutes: 15,
      loading: function (bool) {
        if (bool)
          $('#loading').show();
        else
          $('#loading').hide();
      },
      events: events_url,
      timeFormat: 'h:mm t{ - h:mm t} ',
      dragOpacity: "0.5",
      eventDrop: function (event, dayDelta, minuteDelta, allDay, revertFunc) {
        moveEvent(event, dayDelta, minuteDelta, allDay);
      },

      eventResize: function (event, dayDelta, minuteDelta, revertFunc) {
        resizeEvent(event, dayDelta, minuteDelta);
      },

      eventClick: function (event, jsEvent, view) {
        if(editable) {
          showEventDetails(event);
        }
      }
    });
  }

  $('#create_event_dialog, #desc_dialog').on('submit', "#event_form", function(event) {
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
  })
}

$(document).on("page:load", ready);

$(document).ready(ready);
