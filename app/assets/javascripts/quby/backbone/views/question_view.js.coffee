class Quby.Views.QuestionView extends Backbone.View
  initialize: ->
    @model.on "hide", @hide, @
    @model.on "unhide", @unhide, @
  hide: ->
    @$el.addClass("hidden-childs")
  unhide: ->
    @$el.removeClass("hidden-childs")