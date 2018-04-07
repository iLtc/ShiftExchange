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

window.weekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]