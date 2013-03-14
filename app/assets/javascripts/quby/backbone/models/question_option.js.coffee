class Quby.Models.QuestionOption extends Backbone.Model
  defaults: ->
    hidesQuestions: new Quby.Collections.Questions
    showsQuestions: new Quby.Collections.Questions
  initialize: ->
    @on "hideQuestions", @hideQuestions, @
    @on "unhideQuestions", @unhideQuestions, @
  initShowsHides: ->
    @get("view").$el.attr('hidesQuestions')
  hideQuestions: ->
    @get("hidesQuestions").each (question) ->
      question.trigger "hide"
  unhideQuestions: ->
    @get("hidesQuestions").each (question) ->
      question.trigger "unhide"
