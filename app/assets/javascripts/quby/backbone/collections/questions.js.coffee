class Quby.Collections.Questions extends Backbone.Collection
  model: Quby.Models.Question
  noneVisible: ->
    if @isEmpty()
      return false
    questionNotVisible = (question) ->
      !question.isVisible()
    @.every questionNotVisible
  addAndRegisterInit: (questions) ->
    @add questions.models
    questions.each (question) =>
      initShowHidesCallback = ->
        options = question.get("options")
        options.each (option) =>
          option.initShowsHides @
      @on "initShowsHides", initShowHidesCallback, @