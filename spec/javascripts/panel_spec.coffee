describe "Quby.Models.Panel", ->
  describe "#hidePanelCheck", ->
    describe 'hiding/unhiding triggers', ->
      beforeEach ->
        @question = new Quby.Models.Question
        @question2 = new Quby.Models.Question
        @questionC = new Quby.Collections.Questions([@question, @question2])
        @panel = new Quby.Models.Panel(questions: @questionC)

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
        sinon.stub(@panel, 'hidden').returns false
        sinon.stub(@questionC, 'noneVisible').returns true
        spy = sinon.spy()
        @panel.on "hide", spy
        @question.trigger "hide"
        expect(spy).toHaveBeenCalled()
  
      it 'triggers the unhide event if any question is unhidden', ->
        @panel.hidden = sinon.stub().returns true
        sinon.stub(@questionC, 'noneVisible').returns false
        spy = sinon.spy()
        @panel.on "unhide", spy
        @question.trigger "unhide"
        expect(spy).toHaveBeenCalled()
  
      it 'does not trigger the hide event if not all questions are hidden', ->
        spy = sinon.spy()
        @panel.on "hide", spy
        @question.trigger "hide"
        expect(spy).not.toHaveBeenCalled()

  describe '#initialize', ->
    it 'starts out hidden if all the questions on this panel start out hidden', ->
      question = new Quby.Models.Question(defaultInvisible: true)
      question2 = new Quby.Models.Question(defaultInvisible: true)
      panel = new Quby.Models.Panel(questions: new Quby.Collections.Questions([question, question2]))
      panel.initShowsHides(new Quby.Collections.Questions([question, question2]))
      expect(panel.hidden()).toEqual(true)

    it 'does not start out hidden if not all the questions on this panel start out hidden', ->
      question = new Quby.Models.Question(defaultInvisible: false)
      question2 = new Quby.Models.Question(defaultInvisible: true)
      panel = new Quby.Models.Panel(questions: new Quby.Collections.Questions([question, question2]))
      panel.initShowsHides(new Quby.Collections.Questions([question, question2]))
      expect(panel.hidden()).toEqual(false)

  describe '#initShowsHides', ->
    beforeEach ->
      @questionOption = new Quby.Models.QuestionOption()
      @questionOptionView = new Quby.Views.QuestionOptionView(model: @questionOption)

      @options = new Quby.Collections.QuestionOptions([@questionOption, @questionOption2])
      @question = new Quby.Models.Question(options: @options, type: "radio")

      @allQuestions = new Quby.Collections.Questions([@question])
      @panel = new Quby.Models.Panel(questions: @allQuestions)

    it 'calls initShowsHides on each question\'s question options', ->
      spy = sinon.spy(@questionOption, 'initShowsHides')
      @panel.initShowsHides(@allQuestions)
      expect(spy).toHaveBeenCalledWith(@allQuestions)
      @questionOption.initShowsHides.restore()