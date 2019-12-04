class Quby.Models.Panel extends Backbone.Model
  defaults: ->
    questions: new Quby.Collections.Questions
    view: new Quby.Views.PanelView(model: @)
    panelId: null
    initedShowsHidesCalled: false
  initialize: ->
    panelId = @get('panelId')
    viewSelector = "##{panelId}"
    if panelId
      @get("view").setElement $(viewSelector)[0]

    hidePanelTrigger = ->
      @trigger "hidePanelCheck"
    @get("questions").on "hide", hidePanelTrigger, @
    @get("questions").on "unhide", hidePanelTrigger, @
    @get("questions").on "show", hidePanelTrigger, @
    @get("questions").on "unshow", hidePanelTrigger, @
    @on "hidePanelCheck", @hidePanelCheck, @
    @trigger "hidePanelCheck"

  initShowsHides: (allQuestions) ->
    unless @get 'initedShowsHidesCalled'
      @set('initedShowsHidesCalled', true)
      @get("questions").each (question) ->
        options = question.get("options")
        options.each (option) ->
          option.initShowsHides allQuestions

  hidePanelCheck: ->
    if @hidden()
      if !@get("questions").noneVisible()
        @trigger "unhide"
    else
      if @get("questions").noneVisible()
        @trigger "hide"

  hidden: ->
    @get("view").hidden()