class Quby.Logic.InitQuestions
  constructor: (questionAttributes) ->
    @questions = new Quby.Collections.Questions
    @questionAttributes = questionAttributes

  initializeQuestions: ->
    _.each @questionAttributes, (questionAttribute) =>
      options = @initializeOptions questionAttribute.options
      question = @initializeQuestion(questionAttribute, options)
      @questions.add question
    @questions

  initializeOptions: (optionAttributes) ->
    options = new Quby.Collections.QuestionOptions
    _.each optionAttributes, (attrs) =>
      option = new Quby.Models.QuestionOption
        key: attrs.key
        showsQuestionsKeys: attrs.shows_questions
        hidesQuestionsKeys: attrs.hides_questions
        startChosen: attrs.start_chosen
      element = @initializeOptionViewElement attrs.view_id
      new Quby.Views.QuestionOptionView(model: option, el: element)
      options.add option
    options

  initializeOptionViewElement: (view_id) ->
    $("#" + view_id)[0]

  initializeQuestion: (question, options) ->
    parentQuestion = @questions.findWhere(key: question.parentKey)
    if parentQuestion
      parentOption = parentQuestion.get("options").findWhere(key: question.parentOptionKey)
    new Quby.Models.Question(
      key: question.key
      viewSelector: question.viewSelector
      options: options
      type: question.type
      defaultInvisible: question.default_invisible
      parentQuestion: parentQuestion
      parentOption: parentOption
      deselectable: question.deselectable
    )