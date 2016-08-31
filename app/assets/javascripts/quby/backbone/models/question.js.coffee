class Quby.Models.Question extends Backbone.Model
  defaults: ->
    options: new Quby.Collections.QuestionOptions
    views: []
    lastClickedOption: null
    parentQuestion: null
    parentOption: null
    key: ""
    viewSelector: ""
    type: ""
    defaultInvisible: false
    deselectable: false
    hiddenByOptions: new Quby.Collections.QuestionOptions
    shownByOptions: new Quby.Collections.QuestionOptions

  initialize: ->
    options = @get("options")
    options.on "clicked", @optionClicked, @
    options.on "setLastClickedOption", @setLastClickedOption, @
    @on "hide", @hide, @
    @on "unhide", @unhide, @
    @on "show", @show, @
    @on "unshow", @unshow, @

    viewSelector = @get("viewSelector")
    views = @get("views")
    questionModel = @
    if _.isEmpty viewSelector
      views.push new Quby.Views.QuestionView(model: questionModel)
    else
      $(viewSelector).each (index, element) ->
        views.push new Quby.Views.QuestionView(model: questionModel, el: element)

  isVisible: ->
    _.every @get("views"), (view) ->
      view.isVisible()

  #we cant do this purely with event handlers on the options because we also need to call unhide on
  #the last clicked option and there is no js event for unchecking radio/select options
  optionClicked: (optionModel) ->
    lastClickedOption = @get "lastClickedOption"
    if lastClickedOption != null && lastClickedOption != optionModel && @unchecksLastClicked()
      lastClickedOption.trigger "checkChosen"
    optionModel.trigger "checkChosen"
    @setLastClickedOption optionModel
    true

  setLastClickedOption: (optionModel) ->
    @set "lastClickedOption", optionModel

  unchecksLastClicked: ->
    _.contains(["radio", "select", "scale"], @get("type"))

  hide: (hidingOption)->
    @get("hiddenByOptions").add hidingOption
    @trigger "decideVisibility"
  unhide: (hidingOption)->
    @get("hiddenByOptions").remove hidingOption
    @trigger "decideVisibility"

  show: (showingOption)->
    @get("shownByOptions").add showingOption
    @trigger "decideVisibility"
  unshow: (showingOption)->
    @get("shownByOptions").remove showingOption
    @trigger "decideVisibility"
