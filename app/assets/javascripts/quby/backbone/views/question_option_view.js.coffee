class Quby.Views.QuestionOptionView extends Backbone.View
  tagName: "option"
  events:
    "click" : "clicked"
  clicked: ->
    @model.trigger "clicked", @model