describe "Quby.Collections.Questions", ->
  beforeEach ->
    @questionOption = new Quby.Models.QuestionOption
    @question = new Quby.Models.Question()
    @questionC = new Quby.Collections.Questions
    @questionC.add([@question, {}])

  describe "#hidden", ->
    it "returns all questions that are hidden", ->
      @question.trigger "hide"
      expect(@questionC.hidden()).toEqual([@question])
