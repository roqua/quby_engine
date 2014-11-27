describe "Quby.Collections.Questions", ->
  beforeEach ->
    @questionOption = new Quby.Models.QuestionOption
    @question = new Quby.Models.Question(options: new Quby.Collections.QuestionOptions([@questionOption]))
    @questionC = new Quby.Collections.Questions
    @questionC.add([@question])

  describe "#noneVisible", ->
    it "returns true if all questions are not visible", ->
      @questionC.each (question) ->
        question.isVisible = sinon.stub().returns false
      expect(@questionC.noneVisible()).toEqual(true)
    it "returns false if some questions are visible", ->
      @question.isVisible = sinon.stub().returns true
      expect(@questionC.noneVisible()).toEqual(false)
    it "returns false if there are no questions in the collection", ->
      expect(new Quby.Collections.Questions().noneVisible()).toEqual(false)

  describe "#addQuestions", ->
    it 'adds the question to the collection', ->
      allQuestions = new Quby.Collections.Questions
      sinon.spy(allQuestions, 'add')
      allQuestions.addQuestions(@questionC)
      expect(allQuestions.add).toHaveBeenCalledWith(@questionC.models)