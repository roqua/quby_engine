class Quby.Models.Question extends Backbone.Model
  defaults: ->
    options: new Quby.Collections.QuestionOptions
    hiddenByOptions: new Quby.Collections.QuestionOptions
    shownByOptions: new Quby.Collections.QuestionOptions
    lastClickedOption: null
    key: ""
    viewSelector: ""
    type: ""
  initialize: ->
    @get("options").on "clicked", @optionClicked, @
    @on "add", @addedToCollection
    viewSelector = @get("viewSelector")
    if not _.isEmpty viewSelector
      @set("view", new Quby.Views.QuestionView(model: @, element: $(viewSelector)[0]))
    else
      @set("view", new Quby.Views.QuestionView(model: @))
  addedToCollection: ->
    options = @get("options")
    initShowHidesCallback = ->
      options.trigger "initShowsHides", @collection
    @collection.on "initShowsHides", initShowHidesCallback, @

  hidden: ->
    @get("view").hidden()

  #we cant do this purely with event handlers on the options because we also need to call unhide on
  #the last clicked option and there is no js event for unchecking radio options
  optionClicked: (optionModel) ->
    lastClickedOption = @get "lastClickedOption"
    if lastClickedOption != optionModel
      if lastClickedOption != null && @get("type") == "radio"
        lastClickedOption.trigger "unhideQuestions"
      optionModel.trigger "hideQuestions"
      @set "lastClickedOption", optionModel
