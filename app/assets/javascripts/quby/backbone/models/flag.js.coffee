class Quby.Models.Flag extends Backbone.Model
  defaults: ->
    key: ""
    value: null
    hidesQuestions: new Quby.Collections.Questions
    showsQuestions: new Quby.Collections.Questions
    hidesQuestionsKeys: []
    showsQuestionsKeys: []

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

  doHiding: ->
    value = @get("value")
    if value != null
      if value
        @hideQuestions()
        @showQuestions()
      else
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