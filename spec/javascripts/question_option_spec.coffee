describe "Quby.Models.QuestionOption", ->
  beforeEach ->
    @questionOption = new Quby.Models.QuestionOption(
      hidesQuestionsKeys: ["v_1"]
      showsQuestionsKeys: ["v_2"]
    )
    @questionOptionView = new Quby.Views.QuestionOptionView(model: @questionOption)
    @v_1 = new Quby.Models.Question(key: "v_1")
    @v_2 = new Quby.Models.Question(key: "v_2")
    @questions = new Quby.Collections.Questions([@v_1, @v_2])
    @questionOption.initShowsHides(@questions)

  describe "#click", ->
    it 'triggers clicked on its model', ->
      spy = sinon.spy()
      @questionOption.bind("clicked", spy)
      @questionOptionView.$el.click()
      expect(spy).toHaveBeenCalled()
  describe "#initShowsHides", ->
    it 'looks up the hidesQuestionsKeys in the question collection to initialize the hidesQuestions collection', ->
      @questionOption.get("hidesQuestions").should == new Quby.Collections.Questions([@v_1])
    it 'looks up the showsQuestionsKeys in the question collection to initialize the showsQuestions collection', ->
      @questionOption.get("showsQuestions").should == new Quby.Collections.Questions([@v_2])
