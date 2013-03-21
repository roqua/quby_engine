describe "Quby.Collections.Questions", ->
  beforeEach ->
    @questionOption = new Quby.Models.QuestionOption
    @question = new Quby.Models.Question()
    @questionC = new Quby.Collections.Questions
    @questionC.add([@question, {}])

  describe "#noneVisible", ->
    it "returns true if all questions are not visible", ->
      @questionC.each (question) ->
        question.isVisible = sinon.stub().returns false
      expect(@questionC.noneVisible()).toEqual(true)
    it "returns false if some questions are visible", ->
      @question.isVisible = sinon.stub().returns true
      expect(@questionC.noneVisible()).toEqual(false)

