describe "Quby.Collections.Questions", ->
  beforeEach ->
    @questionOption = new Quby.Models.QuestionOption
    @question = new Quby.Models.Question()
    @questionC = new Quby.Collections.Questions
    @questionC.add([@question, {}])

  describe "#allHidden", ->
    it "returns true if all questions are hidden", ->
      @questionC.each (question) ->
        question.trigger "hide"
      expect(@questionC.allHidden()).toEqual(true)
    it "returns false if not all questions are hidden", ->
      expect(@questionC.allHidden()).toEqual(false)

