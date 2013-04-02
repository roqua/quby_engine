class Quby.Views.QuestionView extends Backbone.View
  initialize: ->
    @model.on "decideVisibility", @decideVisibility, @
    @decideVisibility()

  decideVisibility: ->
    if @isVisible()
      @$el.addClass "show"
      @$el.removeClass "hide"
    else
      @$el.addClass "hide"
      @$el.removeClass "show"

  isVisible: ->
    @shown() || (!@hidden() && !@model.get("defaultInvisible"))

  shown: ->
    !@model.get("shownByOptions").isEmpty()
  hidden: ->
    !@model.get("hiddenByOptions").isEmpty()