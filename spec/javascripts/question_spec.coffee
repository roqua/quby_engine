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

    @targetQuestion.attributes.views[0].$el.html("<input> <textarea></textarea> <select></select>")

  describe "#optionClicked", ->
    it 'triggers checkChosen on the clicked option', ->
      spy = sinon.spy()
      @questionOption.bind("checkChosen", spy)
      @question.optionClicked @questionOption
      expect(spy).toHaveBeenCalled()
    it 'triggers checkChosen on the previously clicked option if the question type is radio', ->
      spy = sinon.spy()
      @questionOption.bind("checkChosen", spy)
      @question.optionClicked @questionOption
      @question.optionClicked @questionOption2
      expect(spy).toHaveBeenCalled()
    it 'it does not call checkChosen on the previously clicked option if the question type is not radio', ->
      @question.set("type", "")
      @question.optionClicked @questionOption
      spy = sinon.spy()
      @questionOption.bind("checkChosen", spy)
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

  describe "view#decideVisibility", ->
    it 'disables input elements when it becomes invisible', ->
      @questionOption.hideQuestions()
      @questionOption.unhideQuestions()
      @questionOption.hideQuestions()
      expect(@targetQuestion.attributes.views[0].$el.find('input[disabled=disabled], select[disabled=disabled], textarea[disabled=disabled]').length).toEqual(3)
    it 'enables input elements when it becomes visible', ->
      @questionOption.hideQuestions()
      @questionOption.unhideQuestions()
      expect(@targetQuestion.attributes.views[0].$el.find('input[disabled!=disabled], select[disabled!=disabled], textarea[disabled!=disabled]').length).toEqual(3)
    it 'replaces show class with hide when it becomes invisible', ->
      @questionOption.hideQuestions()
      @questionOption.unhideQuestions()
      @questionOption.hideQuestions()
      expect(@targetQuestion.attributes.views[0].$el.is('.hide, :not(.show)')).toEqual(true)
    it 'replaces hide class with show when it becomes visible', ->
      @questionOption.hideQuestions()
      @questionOption.unhideQuestions()
      expect(@targetQuestion.attributes.views[0].$el.is('.show, :not(.hide)')).toEqual(true)