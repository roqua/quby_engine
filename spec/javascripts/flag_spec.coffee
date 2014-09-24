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
    @flag.initShowsHides(@questions)

  describe "#initShowsHides", ->
    it 'looks up the hidesQuestionsKeys in the question collection to initialize the hidesQuestions collection', ->
      @flag.get("hidesQuestions").should == new Quby.Collections.Questions([@v_1])
    it 'looks up the showsQuestionsKeys in the question collection to initialize the showsQuestions collection', ->
      @flag.get("showsQuestions").should == new Quby.Collections.Questions([@v_2])
