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
    @get("questions").on "show", hidePanelTrigger, @
    @get("questions").on "unshow", hidePanelTrigger, @
    @on "hidePanelCheck", @hidePanelCheck, @
    @trigger "hidePanelCheck"
  hidePanelCheck: ->
    if @hidden()
      if !@get("questions").noneVisible()
        @trigger "unhide"
    else
      if @get("questions").noneVisible()
        @trigger "hide"

  hidden: ->
    @get("view").hidden()