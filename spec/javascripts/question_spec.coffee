describe "Quby.Models.Question", ->
  beforeEach ->
    @targetQuestion = new Quby.Models.Question
    @targetQuestion2 = new Quby.Models.Question

    col = new Quby.Collections.Questions([@targetQuestion])
    col2 = new Quby.Collections.Questions([@targetQuestion2])
    @questionOption = new Quby.Models.QuestionOption(hidesQuestions: col, showsQuestions: col2)
    @questionOption2 = new Quby.Models.QuestionOption(hidesQuestions: col2)
    @questionOptionView = new Quby.Views.QuestionOptionView(model: @questionOption)
    @questionOptionView2 = new Quby.Views.QuestionOptionView(model: @questionOption2)

    col = new Quby.Collections.QuestionOptions([@questionOption, @questionOption2])
    @question = new Quby.Models.Question(options: col, type: "radio")

  describe "#optionClicked", ->
    it 'triggers chosen on the clicked option', ->
      spy = sinon.spy()
      @questionOption.bind("chosen", spy)
      @question.optionClicked @questionOption
      expect(spy).toHaveBeenCalled()
    it 'calls unchosen on the previously clicked option if the question type is radio', ->
      spy = sinon.spy()
      @questionOption.bind("unchosen", spy)
      @question.optionClicked @questionOption
      @question.optionClicked @questionOption2
      expect(spy).toHaveBeenCalled()
    it 'it does not call unchosen on the previously clicked option if the question type is not radio', ->
      @question.set("type", "")
      spy = sinon.spy()
      @questionOption.bind("unchosen", spy)
      @question.optionClicked @questionOption
      @question.optionClicked @questionOption2
      expect(spy).not.toHaveBeenCalled()

  describe "#hide", ->
    it 'adds the option that is hiding this question to the hiddenByOptions collection', ->
      @questionOption.hideQuestions()
      expect(@targetQuestion.get("hiddenByOptions")).toEqual(new Quby.Collections.QuestionOptions([@questionOption]))

  describe "#unhide", ->
    it 'removes the option that is hiding this question to the hiddenByOptions collection', ->
      @questionOption.unhideQuestions()
      expect(@targetQuestion.get("hiddenByOptions")).toBeEmpty()

  describe "#shown", ->
    it 'adds the option that is showing this question to the shownByOptions collection', ->
      @questionOption.showQuestions()
      expect(@targetQuestion2.get("shownByOptions")).toEqual(new Quby.Collections.QuestionOptions([@questionOption]))

  describe "#unshown", ->
    it 'removes the option that is hiding this question to the hiddenByOptions collection', ->
      @questionOption.unshowQuestions()
      expect(@targetQuestion2.get("shownByOptions")).toBeEmpty()