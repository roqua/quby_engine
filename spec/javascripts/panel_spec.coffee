describe "Quby.Models.Panel", ->
  beforeEach ->
    @question = new Quby.Models.Question
    @question2 = new Quby.Models.Question
    @panel = new Quby.Models.Panel(questions: new Quby.Collections.Questions([@question, @question2]))

  describe "#hidePanelCheck", ->
    it 'is triggered if a question is hidden', ->
      spy = sinon.spy()
      @panel.on "hidePanelCheck", spy
      @question.trigger "hide"
      expect(spy).toHaveBeenCalled()
    it 'is triggered if a question is unhidden', ->
      spy = sinon.spy()
      @panel.on "hidePanelCheck", spy
      @question.trigger "unhide"
      expect(spy).toHaveBeenCalled()
    it 'triggers the hide event if all questions are hidden', ->
      @panel.hidden = sinon.stub().returns false
      spy = sinon.spy()
      @panel.on "hide", spy
      @question.trigger "hide"
      @question2.trigger "hide"
      expect(spy).toHaveBeenCalled()
    it 'triggers the unhide event if any question is unhidden', ->
      @panel.hidden = sinon.stub().returns true
      spy = sinon.spy()
      @panel.on "unhide", spy
      @question.trigger "unhide"
      expect(spy).toHaveBeenCalled()
    it 'does not trigger the hide event if not all questions are hidden', ->
      spy = sinon.spy()
      @panel.on "hide", spy
      @question.trigger "hide"
      expect(spy).not.toHaveBeenCalled()
