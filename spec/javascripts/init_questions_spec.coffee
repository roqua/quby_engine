describe "Quby.Logic.InitQuestions", ->
  beforeEach ->
    @optionAttributes = [
      "key": "a1"
      "hides_questions": []
      "shows_questions": [
        "v_7"
      ]
      "start_chosen": true
      "view_id": "v_4_a1"
    ]

    @questionAttributes =  [
      "key": "v_4"
      "type": "select"
      "default_invisible": false
      "viewSelector": "#item_v_4"
      "parentKey": null
      "parentOptionKey": null
      "options": @optionAttributes
    ,
      "key": "v_7"
      "type": "radio"
      "default_invisible": false,
      "viewSelector": "#item_v_7"
      "parentKey": null
      "parentOptionKey": null
    ]

  describe "#initialize", ->
    it 'initializes an empty questions collection', ->
      initializer = new Quby.Logic.InitQuestions(@questionAttributes)
      expect(initializer.questions).toEqual new Quby.Collections.Questions

    it 'sets the questionattributes', ->
      initializer = new Quby.Logic.InitQuestions(@questionAttributes)
      expect(initializer.questionAttributes).toEqual @questionAttributes

  describe "#initializeQuestions", ->
    it 'initializes the questions by calling initializeOptions', ->
      initializer = new Quby.Logic.InitQuestions(@questionAttributes)
      sinon.spy(initializer, "initializeQuestion")
      initializer.initializeQuestions()
      expect(initializer.initializeQuestion).toHaveBeenCalledWith(_.first(@questionAttributes))
    it 'returns questions', ->
      initializer = new Quby.Logic.InitQuestions(@questionAttributes)
      sinon.spy(initializer, "initializeQuestions")
      initializer.initializeQuestions()
      expect(initializer.initializeQuestions).toHaveReturned(initializer.questions)

  describe "#initializeOptions", ->
    beforeEach ->
      @initializer = new Quby.Logic.InitQuestions()

    it 'returns a collection with all the options', ->
      @options = @initializer.initializeOptions()
      expect(@options).toBeA Quby.Collections.QuestionOptions

    it 'the options have the right attributes', ->
      @options = @initializer.initializeOptions(@optionAttributes)
      expect(@options.first().attributes).toMatch(
        showsQuestionsKeys : [ 'v_7' ],
        hidesQuestionsKeys : [  ],
        startChosen : true
      )

    it 'sets a view on the option model', ->
      @options = @initializer.initializeOptions(@optionAttributes)
      expect(@options.first().get("view")).toBeA Quby.Views.QuestionOptionView

    it 'sets the attributes on the view', ->
      @options = @initializer.initializeOptions(@optionAttributes)
      expect(@options.first().get("view").model).toEqual @options.first()
      expect(@options.first().get("view").el).toEqual jasmine.any(Object)