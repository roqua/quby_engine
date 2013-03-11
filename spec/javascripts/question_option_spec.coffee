describe "Quby.Models.QuestionOption", ->
  beforeEach ->
    @targetQuestion = new Quby.Models.Question
    @targetQuestion2 = new Quby.Models.Question

    col = new Quby.Collections.Questions([@targetQuestion, @targetQuestion2])
    @questionOption = new Quby.Models.QuestionOption(hidesQuestions: col)

    col = new Quby.Collections.Questions([@targetQuestion2])
    @questionOption2 = new Quby.Models.QuestionOption(hidesQuestions: col)
    @questionOptionView = new Quby.Views.QuestionOptionView(model: @questionOption)
    @questionOptionView2 = new Quby.Views.QuestionOptionView(model: @questionOption2)

    col = new Quby.Collections.QuestionOptions([@questionOption, @questionOption2])
    @question = new Quby.Models.Question(options: col)

  describe "#click", ->
    it 'triggers the target question\'s hide event', ->
      spy = sinon.spy()
      @targetQuestion.bind("hide", spy)
      @questionOptionView.$el.click()
      expect(spy).toHaveBeenCalled()
    it 'triggers the previously clicked target question\'s unhide event', ->
      spy = sinon.spy()
      @targetQuestion.bind("unhide", spy)
      @questionOptionView.$el.click()
      @questionOptionView2.$el.click()
      expect(spy).toHaveBeenCalled()