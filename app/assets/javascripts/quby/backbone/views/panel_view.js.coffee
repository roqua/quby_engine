class Quby.Views.PanelView extends Backbone.View
  model: Quby.Models.Panel
  initialize: ->
    @model.on "hide", @hide, @
    @model.on "unhide", @unhide, @
  hide: ->
    @$el.hide()
  unhide: ->
    @$el.show()
  hidden: ->
    @$el.is ":hidden"