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
    option = @
    @get("hidesQuestions").each (question) ->
      question.trigger "hide", option
  unhideQuestions: ->
    option = @
    @get("hidesQuestions").each (question) ->
      question.trigger "unhide", option
  showQuestions: ->
    option = @
    @get("showsQuestions").each (question) ->
      question.trigger "show", option
  unshowQuestions: ->
    option = @
    @get("showsQuestions").each (question) ->
      question.trigger "unshow", option