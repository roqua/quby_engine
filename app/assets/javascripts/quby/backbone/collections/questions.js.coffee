class Quby.Collections.Questions extends Backbone.Collection
  model: Quby.Models.Question
  allHidden: ->
    questionHidden = (question) ->
      question.hidden()
    @.every questionHidden