describe "Quby.Models.QuestionOption", ->
  beforeEach ->
    @questionOption = new Quby.Models.QuestionOption
    @questionOptionView = new Quby.Views.QuestionOptionView(model: @questionOption)

  describe "#click", ->
    it 'triggers clicked on its model', ->
      spy = sinon.spy()
      @questionOption.bind("clicked", spy)
      @questionOptionView.$el.click()
      expect(spy).toHaveBeenCalled()