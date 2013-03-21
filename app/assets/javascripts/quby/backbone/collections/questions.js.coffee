class Quby.Collections.Questions extends Backbone.Collection
  model: Quby.Models.Question
  noneVisible: ->
    if @isEmpty()
      return false
    questionNotVisible = (question) ->
      !question.isVisible()
    @.every questionNotVisible