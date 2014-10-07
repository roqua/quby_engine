class Quby.Models.Flag extends Backbone.Model
  defaults: ->
    key: ""
    value: null
    hidesQuestions: new Quby.Collections.Questions
    showsQuestions: new Quby.Collections.Questions
    hidesQuestionsKeys: []
    showsQuestionsKeys: []
    triggerOn: true

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
    @doHiding()

  doHiding: ->
    value = @get("value")
    if value == @get("triggerOn")
      @hideQuestions()
      @showQuestions()

  hideQuestions: ->
    flag = @
    @get("hidesQuestions").each (question) ->
      question.trigger "hide", flag
  showQuestions: ->
    flag = @
    @get("showsQuestions").each (question) ->
      question.trigger "show", flag