class Quby.Models.Question extends Backbone.Model
  defaults: ->
    options: new Quby.Collections.QuestionOptions
    hiddenByOptions: new Quby.Collections.QuestionOptions
    shownByOptions: new Quby.Collections.QuestionOptions
    lastClickedOption: null
    view: new Quby.Views.QuestionView(model: @)
  initialize: ->
    @get("options").on "clicked", @optionClicked, @
  hidden: ->
    (@get("hiddenByOptions").length > 0) && (@get("shownByOptions").length == 0)

  #we cant do this purely with event handlers on the options because we also need to call unhide on
  #the last clicked option and there is no js event for unchecking options
  optionClicked: (optionModel) ->
    lastClickedOption = @get "lastClickedOption"
    if lastClickedOption != optionModel
      if lastClickedOption != null
        lastClickedOption.unhideQuestions()
      optionModel.hideQuestions()
      @set "lastClickedOption", optionModel
