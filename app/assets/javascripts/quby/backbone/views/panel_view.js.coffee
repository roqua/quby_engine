class Quby.Views.PanelView extends Backbone.View
  model: Quby.Models.Panel
  initialize: ->
    @model.on "hide", @hide, @
    @model.on "unhide", @unhide, @
  hide: ->
    @$el.addClass "noVisibleQuestions"
  unhide: ->
    @$el.removeClass "noVisibleQuestions"
  hidden: ->
    @$el.is ".noVisibleQuestions"