class Quby.Views.QuestionView extends Backbone.View
  initialize: ->
    @model.on "decideVisibility", @decideVisibility, @
    if @model.get("defaultInvisible")
      @decideVisibility()

  decideVisibility: ->
    if @isVisible()
      @$el.addClass "show"
      if @$el.is(".select")
        @$el.find('option').removeAttr("disabled")
      @$el.removeClass "hide"
    else
      @$el.addClass "hide"
      # Chrome counts visible select options as always hidden,
      # so we need to also disable them to signify they are truly hidden
      if @$el.is(".select")
        @$el.find('option').attr("disabled", "disabled")
      @$el.removeClass "show"

  isVisible: ->
    @shown() || (!@hidden() && !@model.get("defaultInvisible"))

  shown: ->
    !@model.get("shownByOptions").isEmpty()
  hidden: ->
    !@model.get("hiddenByOptions").isEmpty()
