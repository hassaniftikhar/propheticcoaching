$(document).ready(function () {
		$( "#tabs" ).tabs();
});				

var counter = 0;
var timer = null;

function tictac(){
    counter++;
    $("#clock").html(counter);
}

function reset()
{
clearInterval(timer);
    counter=0;
}
function startInterval()
{
timer= setInterval("tictac()", 1000);
}
function stopInterval()
{
    clearInterval(timer);
}
function save()
{
clearInterval(timer);
    counter=0;

    var url = window.location.href;
    var parts = url.split("/");
    var mentee_id = parts[parts.length - 2];
    // alert(parts[parts.length - 2]);
    // alert(parts[parts.length - 2]);
    // var url = '/admin/mentees'+( ( mentee_id > 0 ) ? ('/'+mentee_id+'/assign_multiple_coaches'):'/batch_assign_multiple_coaches');
    url = '/users/2/mentees/94/time_slots'

    $.ajax({
      data: 'coach_id=' + '2' + '&mentee_id=' + '94'+ '&time_seconds=' + '120',
      dataType: 'script',
      type: 'post',
      url: url,
      success: function(){
        location.reload();
      }
      ,
      error: function(){
        location.reload();
      }
    });

}
