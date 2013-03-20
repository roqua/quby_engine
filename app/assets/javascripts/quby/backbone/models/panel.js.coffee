class Quby.Models.Panel extends Backbone.Model
  defaults: ->
    questions: new Quby.Collections.Questions
    view: new Quby.Views.PanelView(model: @)
    viewSelector: ""
  initialize: ->
    viewSelector = @get("viewSelector")
    if !_.isEmpty viewSelector
      @get("view").setElement $(viewSelector)[0]

    hidePanelTrigger = ->
      @trigger "hidePanelCheck"
    @get("questions").on "hide", hidePanelTrigger, @
    @get("questions").on "unhide", hidePanelTrigger, @
    @on "hidePanelCheck", @hidePanelCheck, @
  hidePanelCheck: ->
    questionHidden = (question) ->
      question.hidden()
    if @hidden()
      if !@get("questions").every questionHidden
        @trigger "unhide"
    else
      if @get("questions").every questionHidden
        @trigger "hide"

  hidden: ->
    @get("view").hidden()