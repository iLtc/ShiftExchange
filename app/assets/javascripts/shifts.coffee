# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.shiftsController = () ->
  $("#user-menu").dropdown()

window.shiftsIndex = () ->
  shifts = $.parseJSON(shifts_json)
  console.log(shifts)

window.shiftsNew = () ->
  $("#date").datepicker {
    changeMonth: true,
    changeYear: true,
    numberOfMonths: 2
  }

  $("#startTime").timepicker {
    dropdown: false
  }
  $("#endTime").timepicker {
    dropdown: false
  }

  availableLocations = $("#available-locations").val().split(";")
  $("#location").autocomplete {
    source: availableLocations
  }