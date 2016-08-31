class Quby.Views.QuestionOptionView extends Backbone.View
  tagName: "option"
  initialize: ->
    @model.set("view", @)
  events:
    "click" : "clicked"
  clicked: (ev) ->
    @model.trigger "clicked", @model
    true
  chosen: ->
    @$el.is(":selected, :checked")
