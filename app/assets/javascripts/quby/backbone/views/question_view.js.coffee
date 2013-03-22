class Quby.Views.QuestionView extends Backbone.View
  initialize: ->
    @hidden = false
    @shown = false
    @model.on "hide", @hide, @
    @model.on "unhide", @unhide, @
    @model.on "show", @show, @
    @model.on "unshow", @unshow, @
    @decideVisibility()
  hide: ->
    @hidden = true
    @decideVisibility()
  unhide: ->
    @hidden = false
    @decideVisibility()

  show: ->
    @shown = true
    @decideVisibility()
  unshow: ->
    @shown = false
    @decideVisibility()

  decideVisibility: ->
    if @isVisible()
      @$el.addClass "show"
      @$el.removeClass "hide"
      @$el.find(":not(.hidden)").show()
    else
      @$el.addClass "hide"
      @$el.removeClass "show"
      @$el.find(":not(.hidden)").hide()

  isVisible: ->
    @shown || (!@hidden && !@model.get("defaultInvisible"))