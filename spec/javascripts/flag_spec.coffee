describe "Quby.Models.Flag", ->
  beforeEach ->
    @flag = new Quby.Models.Flag(
      key: 'testkey'
      hidesQuestionsKeys: ["v_1"]
      showsQuestionsKeys: ["v_2"]
    )
    @v_1 = new Quby.Models.Question(key: "v_1")
    @v_2 = new Quby.Models.Question(key: "v_2")
    @questions = new Quby.Collections.Questions([@v_1, @v_2])

  describe "#initShowsHides", ->
    it 'looks up the hidesQuestionsKeys in the question collection to initialize the hidesQuestions collection', ->
      @flag.initShowsHides(@questions)
      @flag.get("hidesQuestions").should == new Quby.Collections.Questions([@v_1])
    it 'looks up the showsQuestionsKeys in the question collection to initialize the showsQuestions collection', ->
      @flag.initShowsHides(@questions)
      @flag.get("showsQuestions").should == new Quby.Collections.Questions([@v_2])
    it 'calls doHiding', ->
      spy = sinon.spy(@flag, 'doHiding')
      @flag.initShowsHides(@questions)
      expect(spy).toHaveBeenCalled()
