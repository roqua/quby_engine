class Quby.Views.QuestionOptionView extends Backbone.View
  tagName: "option"
  initialize: ->
    @model.set("view", @)
  events:
    "click" : "clicked"
  clicked: ->
    @model.trigger "clicked", @model
  chosen: ->
    @$el.is(":selected, :checked")
