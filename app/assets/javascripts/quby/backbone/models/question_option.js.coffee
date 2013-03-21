class Quby.Models.QuestionOption extends Backbone.Model
  defaults: ->
    hidesQuestions: new Quby.Collections.Questions
    showsQuestions: new Quby.Collections.Questions
    hidesQuestionsKeys: []
    showsQuestionsKeys: []
  initialize: ->
    @on "hideQuestions", @hideQuestions, @
    @on "unhideQuestions", @unhideQuestions, @
    @on "add", @addedToCollection, @
  addedToCollection: ->
    if !_.isEmpty(@get("hidesQuestionsKeys")) or !_.isEmpty(@get("showsQuestionsKeys"))
      @collection.on "initShowsHides", @initShowsHides, @
  initShowsHides: (allQuestions)->
    showsQuestionsKeys = @get("showsQuestionsKeys")
    showsQuestions = allQuestions.select( (question) ->
      _.contains(showsQuestionsKeys, question.get("key"))
    )
    @get("showsQuestions").add(showsQuestions)

    hidesQuestionsKeys = @get("hidesQuestionsKeys")
    hidesQuestions = allQuestions.select( (question) ->
      _.contains(hidesQuestionsKeys, question.get("key"))
    )
    @get("hidesQuestions").add(hidesQuestions)
    if @get("view").chosen()
      @trigger "clicked", @

  hideQuestions: ->
    @get("hidesQuestions").each (question) ->
      question.trigger "hide"
  unhideQuestions: ->
    @get("hidesQuestions").each (question) ->
      question.trigger "unhide"
