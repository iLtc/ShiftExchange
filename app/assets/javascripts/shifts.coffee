# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addShift = (shift) ->
  wday = weekday[new Date(shift['start']).getDay()].toLowerCase()
  period = shift['period']

  start = formatTime(new Date(shift['start']))
  end = formatTime(new Date(shift['end']))

  location = shift['location']

  id = shift['id']

  shiftClass = wday + '-' + period

  shiftLink = shifts_link + '/' + id

  shiftContent = ''

  console.log(shiftClass, shiftLink, shiftContent)

window.shiftsController = () ->
  $("#user-menu").dropdown()

window.shiftsIndex = () ->
  shifts = $.parseJSON(shifts_json)
  console.log(shifts)

  addShift shift for shift in shifts

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