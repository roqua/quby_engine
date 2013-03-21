class Quby.Models.Question extends Backbone.Model
  defaults: ->
    options: new Quby.Collections.QuestionOptions
    views: []
    lastClickedOption: null
    key: ""
    viewSelector: ""
    type: ""
  initialize: ->
    @get("options").on "clicked", @optionClicked, @
    @on "add", @addedToCollection

    viewSelector = @get("viewSelector")
    views = @get("views")
    questionModel = @
    if _.isEmpty viewSelector
      views.push new Quby.Views.QuestionView(model: questionModel)
    else
      $(viewSelector).each (index, element) ->
        views.push new Quby.Views.QuestionView(model: questionModel, el: element)
  addedToCollection: ->
    options = @get("options")
    initShowHidesCallback = ->
      options.trigger "initShowsHides", @collection
    @collection.on "initShowsHides", initShowHidesCallback, @

  hidden: ->
    _.every @get("views"), (view) ->
      view.hidden()

  #we cant do this purely with event handlers on the options because we also need to call unhide on
  #the last clicked option and there is no js event for unchecking radio/select options
  optionClicked: (optionModel) ->
    lastClickedOption = @get "lastClickedOption"
    if lastClickedOption != optionModel
      if lastClickedOption != null && _.contains(["radio", "select"], @get("type"))
        lastClickedOption.trigger "unhideQuestions"
      optionModel.trigger "hideQuestions"
      @set "lastClickedOption", optionModel
