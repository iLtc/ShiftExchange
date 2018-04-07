window.weekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

window.formatTime = (date) ->
  hr = date.getHours();
  min = date.getMinutes();

  if min < 10
    min = "0" + min

  ampm = "AM"

  if hr > 12
    hr -= 12
    ampm = "PM"

  hr + ":" + min + " "+ ampm

ready = ->
  controller = $("#controller").val()
  action = $("#action").val()
  controllerFunc = controller + 'Controller'
  actionFunc = controller + action

  try
    do window[controllerFunc]
  catch e
    console.log "controllerFunc = " + controllerFunc
    console.log e.message

  try
    do window[actionFunc]
  catch e
    console.log "actionFunc = " + actionFunc
    console.log e.message

$(document).on('turbolinks:load', ready)