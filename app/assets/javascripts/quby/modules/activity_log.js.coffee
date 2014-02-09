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

    $(document).on 'panel_activated', (e, panel)->
      if $panel.attr("id")
        appendLog("Panel changed: " + panel.attr("id"))

$ ->
  $("form[data-log-activity]").logFormActivity();