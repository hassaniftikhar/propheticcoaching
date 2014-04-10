$(document).ready(function () {
		$( "#tabs" ).tabs();
    // $('tbody#mentee_detail_list').html_safe('<%= escape_javascript render :partial => "/mentees/mentee_detail_list", :locals => {:mentees => @mentees} %>');
    // $('#paginator').html_safe('<%= escape_javascript(paginate(@mentees, :remote => true).to_s) %>');
    // $('tbody#mentee_detail_list').html('<%= escape_javascript  render :partial => "/mentees/mentee_detail_list", :locals => {:mentees => @mentees} %>');
    // $('tbody#mentee_detail_list').html("<%= escape_javascript  render :partial => '/mentees/mentee_detail_list', :locals => {:mentees => @mentees} %>");
    // var test_c = 100;
    // var menteeName = <%= @mentees.first.to_json %>;
    // $('tbody#mentee_detail_list').html(menteeName);
    // $('tbody#mentee_detail_list').val(<%= @mentees.to_json %>);
    // alert("#{@mentees.first}");

    // $('#paginator').html('<%= escape_javascript(paginate(@mentees, :remote => true).to_s) %>');

});				


var counter = 0;
var timer = null;
var display_time = ' ';
var start_time = 0
var event_id = 0;
var inputs;

function tictac(){
    counter++;
    display_time = formatTime(start_time-counter);
    if(start_time-counter >= 0)
    {
      // alert(display_time);
      $("#clock-"+event_id).html(display_time);
    }
    else
    {
      stopInterval(event_id);
    }
}
function startInterval(id, start_counter)
{
  start_time = start_counter;
  counter = 0
  event_id = id
  // alert(start_time);
  timer= setInterval("tictac()", 1000);
  inputs = document.getElementsByClassName('button');
  for (var i = 0; i < inputs.length; i++) {
      if (inputs[i].id === 'stop-'+id) {
          inputs[i].disabled = false;
      }
      else
      {
          inputs[i].disabled = true;
      }
  }  
}
function stopInterval(id)
{

    var url = window.location.href;
    var parts = url.split("/");
    var mentee_id = parts[parts.length - 1]
    var coach_id = parts[parts.length - 3];
    // alert(coach_id);
    // alert(parts[parts.length - 2]);
    // alert(parts[parts.length - 2]);
    // var url = '/admin/mentees'+( ( mentee_id > 0 ) ? ('/'+mentee_id+'/assign_multiple_coaches'):'/batch_assign_multiple_coaches');
    // url = '/users/2/mentees/94/time_slots'
    console.log("event_id: " + id);
    // alert(counter);
    url = "/events/" + id + "/time_slots";
    $.ajax({
      // data: 'event_id=' + id + '&time_seconds=' + counter.to_s,
      data: 'event_id=' + id + '&time_seconds='+ counter + '&coach_id=' + coach_id + '&mentee_id=' + mentee_id,
      dataType: 'script',  
      type: 'post',
      url: url,
      success: function(){
        // alert(data);
        location.reload();
      }
      ,
      error: function(){
        // alert(data);
        location.reload();
      }
    });
    clearInterval(timer);
    counter = 0;
    start_time = 0;
    for (var i = 0; i < inputs.length; i++) {
      inputs[i].disabled = false;
    }  
}

function formatTime(seconds)
{
  var formated_time = [
      Math.floor(seconds / 3600), // an hour has 3600 seconds
      Math.floor((seconds % 3600) / 60), // a minute has 60 seconds
      seconds % 60
  ];
  // 0 padding and concatation
  formated_time = formated_time.map(function(time) {
      return time < 10 ? '0' + time : time;
  }).join(':');
  // alert(formated_time);
  return formated_time;
}

  // document.getElementsById('start').disabled = true;
  // document.getElementsById('start').value = 'Y';  

