class Quby.Collections.Questions extends Backbone.Collection
  model: Quby.Models.Question
  noneVisible: ->
    questionNotVisible = (question) ->
      !question.isVisible()
    @.every questionNotVisible