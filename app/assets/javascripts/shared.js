$( document ).ready(function() {

  $('body').on('click', '#event_starttime_1i', function (event) {
    document.getElementById("event_endtime_1i").selectedIndex = document.getElementById("event_starttime_1i").selectedIndex;
  });
  $('body').on('click', '#event_starttime_2i', function (event) {
    document.getElementById("event_endtime_2i").selectedIndex = document.getElementById("event_starttime_2i").selectedIndex;
  });
  $('body').on('click', '#event_starttime_3i', function (event) {
    document.getElementById("event_endtime_3i").selectedIndex = document.getElementById("event_starttime_3i").selectedIndex;
  });
  $('body').on('click', '#event_starttime_4i', function (event) {
    selected_index4 = document.getElementById("event_starttime_4i").selectedIndex
    last_index4 = document.getElementById("event_starttime_4i").options.length-1
    if(selected_index4 == last_index4) {
    document.getElementById("event_endtime_4i").selectedIndex = selected_index4;
    }
    else {
    document.getElementById("event_endtime_4i").selectedIndex = selected_index4 + 1;      
    }
  });
  $('body').on('click', '#event_starttime_5i', function (event) {
    selected_index5 = document.getElementById("event_starttime_5i").selectedIndex
    last_index5 = document.getElementById("event_starttime_5i").options.length-1
    if(selected_index5 == last_index5) {
    document.getElementById("event_endtime_5i").selectedIndex = selected_index5;
    }
    else {
    document.getElementById("event_endtime_5i").selectedIndex = selected_index5 + 1;      
    }
  });



  $('body').on('click', '#task_starttime_1i', function (event) {
    document.getElementById("task_endtime_1i").selectedIndex = document.getElementById("task_starttime_1i").selectedIndex;
  });
  $('body').on('click', '#task_starttime_2i', function (event) {
    document.getElementById("task_endtime_2i").selectedIndex = document.getElementById("task_starttime_2i").selectedIndex;
  });
  $('body').on('click', '#task_starttime_3i', function (event) {
    document.getElementById("task_endtime_3i").selectedIndex = document.getElementById("task_starttime_3i").selectedIndex;
  });
  $('body').on('click', '#task_starttime_4i', function (event) {
    selected_index4 = document.getElementById("task_starttime_4i").selectedIndex
    last_index4 = document.getElementById("task_starttime_4i").options.length-1
    if(selected_index4 == last_index4) {
    document.getElementById("task_endtime_4i").selectedIndex = selected_index4;
    }
    else {
    document.getElementById("task_endtime_4i").selectedIndex = selected_index4 + 1;      
    }
  });
  $('body').on('click', '#task_starttime_5i', function (event) {
    selected_index5 = document.getElementById("task_starttime_5i").selectedIndex
    last_index5 = document.getElementById("task_starttime_5i").options.length-1
    if(selected_index5 == last_index5) {
    document.getElementById("task_endtime_5i").selectedIndex = selected_index5;
    }
    else {
    document.getElementById("task_endtime_5i").selectedIndex = selected_index5 + 1;      
    }
  });

});
