describe "Questions", ->
  beforeEach ->
    @view = new Backbone.View
    @question = new Question
    @questionC = new Questions
  describe "#hidden", ->
    it "returns all questions that are hidden", ->
      console.log "AAAAA" + @questionC

      expect(true).toEqual(false)
