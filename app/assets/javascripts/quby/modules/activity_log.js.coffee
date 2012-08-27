$ = jQuery

$.fn.logFormActivity = ->
  this.each ->
    form = $(this)
    logField = $(form.data("log-activity"))

    appendLog = (text) ->
      line = "[" + (new Date().toGMTString()) + "] " + text + "\n"
      logField.val(logField.val() + line)

    form.find("input, textfield, select").change ->
      appendLog("Question changed: " + $(this).attr("id") + " " + $(this).attr("name") + " " + $(this).val())

    form.find("fieldset").bind "panelChange", ->
      appendLog("Panel changed: " + $(this).attr("id"))

$ ->
  $("form[data-log-activity]").logFormActivity();