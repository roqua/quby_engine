describe "Quby.Models.QuestionOption", ->
  beforeEach ->
    @targetQuestion = new Quby.Models.Question(elementId: "targetQuestion")
    @questionOption = new Quby.Models.QuestionOption(hidesQuestions: new Quby.Collections.Questions([@targetQuestion]))
    @question = new Quby.Models.Question(hiddenByOptions: [@questionOption])

  describe "#on-changed", ->
    it 'triggers the target question\'s hide function', ->
      console.log @questionOption.get("hidesQuestions")