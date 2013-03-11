class Quby.Collections.Questions extends Backbone.Collection
  model: Quby.Models.Question
  hidden: ->
    @.select (question) ->
      question.hidden()