class Quby.Models.QuestionOption extends Backbone.Model
  defaults: ->
    hidesQuestions: new Quby.Collections.Questions
    showsQuestions: new Quby.Collections.Questions
    hidesQuestionsKeys: []
    showsQuestionsKeys: []
  initialize: ->
    @on "chosen", @chosen, @
    @on "unchosen", @unchosen, @
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

  chosen: ->
    @hideQuestions()
    @showQuestions()
  unchosen: ->
    @unhideQuestions()
    @unshowQuestions()
  hideQuestions: ->
    @get("hidesQuestions").each (question) ->
      question.trigger "hide"
  unhideQuestions: ->
    @get("hidesQuestions").each (question) ->
      question.trigger "unhide"
  showQuestions: ->
    @get("showsQuestions").each (question) ->
      question.trigger "show"
  unshowQuestions: ->
    @get("showsQuestions").each (question) ->
      question.trigger "unshow"