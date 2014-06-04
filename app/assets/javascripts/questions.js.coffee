# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#alert($("#question_query").val())
console.log($("#question_query").parent())
console.log($("#question_query").val())
$("table.table-striped").highlight($("#question_query").val())