describe "Quby.Collections.Flags", ->
  describe "#initShowsHides", ->
    beforeEach ->
      @flagsC = new Quby.Collections.Flags
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
      @flagsC.add([@flag1, @flag2])
    it "calls initshowshides on each flag", ->
        spy1 = sinon.spy(@flagsC.first(), 'initShowsHides')
        spy2 = sinon.spy(@flagsC.last(), 'initShowsHides')
        @flagsC.initShowsHides(@questions)
        expect(spy1).toHaveBeenCalledWith(@questions)
        expect(spy2).toHaveBeenCalledWith(@questions)

  describe '#addFlags', ->
    beforeEach ->
      @flagsC = new Quby.Collections.Flags
    it 'combines the values from the flag_values object with the definitions from the flag_definitions object', ->
      flag_values =
        smokes: true
      flag_definitions =
        smokes:
          key: "smokes"
          description_true: "De invuller rookt"
          description_false: "De invuller rookt niet"
          internal: false
          shows_questions: []
          hides_questions:[]
        last_measurement_of_day:
          key: "last_measurement_of_day"
          description_true: "Laatste meting van de dag"
          description_false: "Niet de laatste meting van de dag"
          internal: true
          shows_questions: []
          hides_questions: []
      @flagsC.addFlags(flag_definitions, flag_values)
      expect(@flagsC.toArray()[0].get('key')).toEqual 'smokes'
      expect(@flagsC.toArray()[0].get('value')).toEqual true
      expect(@flagsC.toArray()[1].get('key')).toEqual 'last_measurement_of_day'
      expect(@flagsC.toArray()[1].get('value')).toEqual null
