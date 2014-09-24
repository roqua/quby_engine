describe "Quby.Collections.Flags", ->
  beforeEach ->
    @flag1 = new Quby.Models.Flag(
      key: 'test1'
      hidesQuestionsKeys: ["v_1"]
      showsQuestionsKeys: ["v_2"]
    )
    @flag2 = new Quby.Models.Flag(
      key: 'test2'
      hidesQuestionsKeys: ["v_2"]
      showsQuestionsKeys: ["v_1"]
    )
    @v_1 = new Quby.Models.Question(key: "v_1")
    @v_2 = new Quby.Models.Question(key: "v_2")
    @questions = new Quby.Collections.Questions([@v_1, @v_2])
    @flagsC = new Quby.Collections.Flags
    @flagsC.add([@flag1, @flag2])

  describe "#initShowsHides", ->
    it "calls initshowshides on each flag", ->
      spy1 = sinon.spy(@flagsC.first(), 'initShowsHides')
      spy2 = sinon.spy(@flagsC.last(), 'initShowsHides')
      @flagsC.initShowsHides(@questions)
      expect(spy1).toHaveBeenCalledWith(@questions)
      expect(spy2).toHaveBeenCalledWith(@questions)
