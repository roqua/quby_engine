describe "Quby.Logic.InitQuestions", ->
  beforeEach ->
    @optionAttributes = [
      "key": "a1"
      "hidesQuestions": []
      "showsQuestions": [
        "v_7"
      ]
      "startChosen": true
      "viewId": "v_4_a1"
    ]

    @questionAttributes =  [
      "key": "v_4"
      "type": "select"
      "defaultInvisible": false
      "viewSelector": "#item_v_4"
      "parentKey": null
      "parentOptionKey": null
      "options": @optionAttributes
    ,
      "key": "v_5"
      "type": "string"
      "defaultInvisible": false
      "viewSelector": "#item_v_5"
      "parentKey": "v_4"
      "parentOptionKey": "a1"
    ,
      "key": "v_7"
      "type": "radio"
      "defaultInvisible": false,
      "viewSelector": "#item_v_7"
      "parentKey": null
      "parentOptionKey": null
      "deselectable": true
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
      expect(@options.first().get("key")).toEqual 'a1'
      expect(@options.first().get("showsQuestionsKeys")).toEqual ['v_7']
      expect(@options.first().get("hidesQuestionsKeys")).toEqual []
      expect(@options.first().get("startChosen")).toEqual true

    it 'sets a view on the option model', ->
      @options = @initializer.initializeOptions(@optionAttributes)
      expect(@options.first().get("view")).toBeA Quby.Views.QuestionOptionView

    it 'sets the attributes on the view', ->
      @options = @initializer.initializeOptions(@optionAttributes)
      expect(@options.first().get("view").model).toEqual @options.first()
      expect(@options.first().get("view").el).toEqual jasmine.any(Object)

  describe "#initializeQuestion", ->
    it 'leaves the parentQuestion to null if there was no parentKey', ->
      initializer = new Quby.Logic.InitQuestions(@questionAttributes)
      question = initializer.initializeQuestion(@questionAttributes[0])
      expect(question.get("parentQuestion")).toBeNull()

    it 'leaves the parentOption to null if there was no parentOptionKey', ->
      initializer = new Quby.Logic.InitQuestions(@questionAttributes)
      question = initializer.initializeQuestion(@questionAttributes[0])
      expect(question.get("parentOption")).toBeNull()

    it 'sets the parentQuestion to the question that has the parentKey as key', ->
      initializer = new Quby.Logic.InitQuestions(@questionAttributes)
      parentQuestion = initializer.initializeQuestion(@questionAttributes[0])
      initializer.questions.add parentQuestion
      subQuestion = initializer.initializeQuestion(@questionAttributes[1])
      expect(subQuestion.get("parentQuestion")).toEqual parentQuestion

    it 'sets the parentOption to the option that has the parentOptionkey as key', ->
      initializer = new Quby.Logic.InitQuestions(@questionAttributes)
      parentQuestion = initializer.initializeQuestion(@questionAttributes[0],
                                                      initializer.initializeOptions(@optionAttributes))
      parentOption = parentQuestion.get("options").first()
      initializer.questions.add parentQuestion
      subQuestion = initializer.initializeQuestion(@questionAttributes[1])
      expect(parentOption).toBeDefined()
      expect(subQuestion.get("parentOption")).toEqual parentOption

    it 'sets the question\'s attributes', ->
      initializer = new Quby.Logic.InitQuestions(@questionAttributes)
      question = initializer.initializeQuestion(@questionAttributes[2])
      expect(question.get('deselectable')).toEqual true
      expect(question.get('defaultInvisible')).toEqual false
      expect(question.get('key')).toEqual 'v_7'
      expect(question.get('type')).toEqual 'radio'
