jQuery ->
  mentees = $('#event_mentee_id').html()
  coach = $('#event_coach_id :selected').text()
  options = $(mentees).filter("optgroup[label='#{coach}']").html()
  if options
    $('#event_mentee_id').html(options)
    $('#event_mentee_id').parent().show()

  $('#event_coach_id').change ->
    coach = $('#event_coach_id :selected').text()
    options = $(mentees).filter("optgroup[label='#{coach}']").html()
    console.log(options)
    if options
      $('#event_mentee_id').html(options)
      $('#event_mentee_id').parent().show()
    else
      $('#event_mentee_id').empty()
      $('#event_mentee_id').parent().hide()



 






 
