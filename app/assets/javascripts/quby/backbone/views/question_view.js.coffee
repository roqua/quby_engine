class Quby.Views.QuestionView extends Backbone.View
  initialize: ->
    @model.on "decideVisibility", @decideVisibility, @
    if @model.get("defaultInvisible")
      @decideVisibility()

  decideVisibility: ->
    if @isVisible()
      @$el.addClass "show"
      @$el.removeClass "hide"
      @$el.find('input, select, textarea').each (index, element)->
        $(element).attr("disabled", false)
    else
      @$el.addClass "hide"
      @$el.removeClass "show"
      @$el.find('input, select, textarea').each  (index, element)->
        $(element).attr("disabled", true)

  isVisible: ->
    @shown() || (!@hidden() && !@model.get("defaultInvisible"))

  shown: ->
    !@model.get("shownByOptions").isEmpty()
  hidden: ->
    !@model.get("hiddenByOptions").isEmpty()