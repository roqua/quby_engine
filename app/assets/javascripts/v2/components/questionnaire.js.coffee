question_entity_classes = [
  "Quby::Questionnaires::Entities::Questions::RadioQuestion",
  "Quby::Questionnaires::Entities::Questions::FloatQuestion",
  "Quby::Questionnaires::Entities::Questions::IntegerQuestion"
]

class @Questionnaire extends React.Component
  displayName: "Questionnaire"

  constructor: (props) ->
    super props
    @state =
      answers: @initialAnswerHash()
      activePanelIdx: 0

    @handleAnswerChange = @handleAnswerChange.bind(@)
    @handleNextPanel = @handleNextPanel.bind(@)
    @handlePrevPanel = @handlePrevPanel.bind(@)
    @handleFinish = @handleFinish.bind(@)


  initialAnswerHash: ->
    _.chain(@props.questionnaire.panels)
     .map (panel) -> panel.items
     .flatten()
     .filter (item) -> item.key # Only questions have a key?
     .map (item) -> [item.key, not item.default_invisible] ? null
     .compact()
     .map ([key, visible]) -> [key, {value: null, visible: visible, error: false, errorMessages: {}}]
     .fromPairs()
     .value()

  question: (key) ->
    _.chain(@props.questionnaire.panels)
     .map (panel) -> panel.items
     .flatten()
     .find (item) -> item.key == key
     .value()

  handleAnswerChange: (ev) ->
    console.log(ev.target)
    key = ev.target.name
    answers = _.clone @state.answers
    previousAnswer = @state.answers*
    question = @question(key)

    # TODO: what about strings? :)
    answerValue = parseInt(ev.target.value)

    console.log "handleAnswerChange", key, answerValue, question

    # deselectable
    if question.deselectable and answers[key].value == answerValue then answerValue = null

    # hide and show
    if question.options
      hideKeys = @dependentQuestionKeys(question)
      console.log(hideKeys)
      _.map hideKeys, (questionKey) -> answers[questionKey].visible = false

      if answerValue != null
        _.chain(question.options)
         .find (option) -> option.value == answerValue
         .get "shows_questions"
         .tap console.log
         .map (questionKey) ->
            answers[questionKey].visible = true
            questionKey
         # .map (questionKey) =>
         #    if answers[questionKey].value
         #      q = @question(questionKey)
         .value()



    answers[key].value = answerValue

    @setState
      answers: answers

  dependentQuestionKeys: (question, result = []) ->
    if question.options
      _.chain(question.options)
       .map (option) -> option.shows_questions
       .flatten()
       .uniq()
       .reduce (acc, questionKey) =>
          q = @question(questionKey)
          @dependentQuestionKeys(q, _.concat(acc, questionKey))
       , result
       .value()
    else
      _.uniq(result)

  handleNextPanel: (ev) ->
    errors = @validatePanel(@state.activePanelIdx)
    return if errors
    @setState
      activePanelIdx: @state.activePanelIdx + 1
      () -> window.scrollTo(0, 0)

  handlePrevPanel: (ev) ->
    @setState
      activePanelIdx: @state.activePanelIdx - 1

  handleFinish: (ev) ->
    # TODO Validate all panels and save results

  validatePanel: (panelIdx) ->
    # questions = _.filter @props.questionnaire.panels[panelIdx].items, (item) => item.class in question_entity_classes
    questions = _.filter @props.questionnaire.panels[panelIdx].items, (item) => item.key
    answers = _.map questions, (question) => [question.key, @validateAnswer(question)]
    @setState answers: _.merge(@state.answers, _.fromPairs(answers))
    _.some _.fromPairs(answers), (answer, key) => answer.error

  validateAnswer: (question) ->
    answer = @state.answers[question.key]
    _.each question.validations, (validation) =>
      answer = Validator.get(validation).validate(answer)
      # console.log question.key, answer
    answer

  render: ->
    React.createElement "div",
      className: @props.display_mode,
      _.map @props.questionnaire.panels, (panel, panelIdx) =>
          @renderPanel panel, panelIdx

  renderPanel: (panel, panelIdx) ->
    panelClasses = ["panel"]
    if panelIdx == 0 then panelClasses.push "first"
    if panelIdx == @props.questionnaire.panels.length - 1 then panelClasses.push "last-panel"
    if panelIdx != @state.activePanelIdx then panelClasses.push "hidden"

    React.createElement "fieldset",
      key: "panel#{panelIdx}",
      className: panelClasses.join(" "),
      id: "panel#{panelIdx}",
      React.createElement "h1", {}, panel.title
      _.map panel.items, (item, itemIdx) =>
        switch item.class
          when "Quby::Questionnaires::Entities::Text" then @renderText item, panelIdx, itemIdx
          when "Quby::Questionnaires::Entities::Questions::RadioQuestion" then @renderRadioQuestion item, panelIdx, itemIdx
          when "Quby::Questionnaires::Entities::Questions::FloatQuestion" then @renderFloatQuestion item, panelIdx, itemIdx
          when "Quby::Questionnaires::Entities::Questions::IntegerQuestion" then @renderIntegerQuestion item, panelIdx, itemIdx
          else @renderNotImplemented item, panelIdx, itemIdx
      @renderProgressBar panelIdx, @props.questionnaire.panels.length
      @renderProgressButtons panelIdx, @props.questionnaire.panels.length

  renderNotImplemented: (item, panelIdx, itemIdx) ->
    React.createElement "div",
      className: "item text",
      "Not yet implemented: #{item.class}"

  renderProgressBar: (panelIdx, panelCount) ->
    sliderClasses = ["progress-slider"]
    if panelCount > 25 then sliderClasses.push "long-list"

    React.createElement "div",
      className: "progress-bar",
      React.createElement "div",
        className: "progress-wrapper",
        React.createElement "div",
          className: sliderClasses.join(" "),
          @renderProgressSteps panelIdx, panelCount
        React.createElement "div",
          className: "progress-details",
          "Stap #{panelIdx + 1} van #{panelCount}"

  renderProgressSteps: (panelIdx, panelCount) ->
    _.map _.range(1, panelCount + 1), (idx) =>
      stepClasses = ["progress-stop", "step-#{idx}"]
      if idx <= panelIdx + 1 then stepClasses.push "active"
      if idx == 1 then stepClasses.push "first-child"
      if idx == panelCount then stepClasses.push "last-child"
      if idx == panelIdx + 1 then stepClasses.push "current"

      React.createElement "span",
        key: idx,
        className: stepClasses.join(" "),
        idx

  renderProgressButtons: (panelIdx, panelCount) ->
    React.createElement "div",
      className: "buttons",
      if panelIdx == 0
        if false # @props.questionnaire.enable_previous_questionnaire_button
          React.createElement "div", className: "back",
            React.createElement "button", {}, "← Vorige vragenlijst"
      else
        React.createElement "div", className: "prev",
          React.createElement "button", onClick: @handlePrevPanel, "← Terug"
      React.createElement "div", className: "abort",
        if @props.questionnaire.abortable
          React.createElement "button", {}, "Stoppen"
      if panelIdx < panelCount - 1
        React.createElement "div", className: "next",
          React.createElement "button", onClick: @handleNextPanel, "Verder →"
      else
        React.createElement "div", className: "save",
          React.createElement "button", onClick: @handleFinish, "Klaar"

  renderText: (item, panelIdx, itemIdx) ->
    React.createElement "div",
      key: "item#{panelIdx}-#{itemIdx}",
      className: "item text vertical",
      React.createElement "div",
        className: "text",
        dangerouslySetInnerHTML:
          __html: item.text

  renderRadioQuestion: (item, panelIdx, itemIdx) ->
    questionRenderer = switch item.type
      when "scale" then @renderRadioScaleQuestion.bind(@)
      when "radio" then @renderRadioRadioQuestion.bind(@)
      else @renderRadioRadioQuestion.bind(@)

    answer = @state.answers[item.key]
    # console.log "renderRadioQuestion", answer
    errorDiv = if answer.error
      errorClass =
        _.chain(answer.errorMessages)
         .keys()
         .join " "
         .value()
      errorMessages =
        _.chain(answer.errorMessages)
         .values()
         .join " "
         .value()
      React.createElement "div",
        className: "error #{errorClass}",
        errorMessages
    else
      React.createElement "div", className: "hidden", ""

    errorClass = if answer.error then "errors" else ""
    hiddenClass = if not answer.visible then "hidden" else ""

    React.createElement "div",
      key: "item#{panelIdx}-#{itemIdx}",
      className: "item #{item.type} horizontal #{errorClass} #{hiddenClass}",
      errorDiv,
      React.createElement "div",
        className: "main",
        React.createElement "label",
          dangerouslySetInnerHTML:
            __html: item.title
      React.createElement "div",
        className: "description-and-fields",
        React.createElement "div",
          className: "description",
          item.description
        questionRenderer(item)


  renderRadioScaleQuestion: (item) ->
    optionWidth = "optionwidth#{item.options.length}"
    deselectableClass = if item.deselectable then "deselectable" else ""
    answerGiven = @state.answers[item.key].value

    React.createElement "div",
      className: "fields",
      React.createElement "table",
        border: 0,
        cellSpacing: 0,
        React.createElement "tbody", {},
          React.createElement "tr", {},
            _.map item.options, (option, optionIdx) =>
              valueSpan = if item.showValues in ["all", @props.display_mode]
                [
                  React.createElement "span", className: "value", option.value
                  React.createElement "br", {}
                ]

              React.createElement "td",
                key: option.view_id,
                className: "option #{optionWidth}",
                htmlFor: item.key,
                valueSpan,
                React.createElement "span", {},
                  React.createElement "input",
                    type: "radio",
                    value: option.value,
                    name: item.key,
                    id: option.view_id,
                    className: "scale #{deselectableClass}",
                    checked: answerGiven == option.value,
                    onClick: @handleAnswerChange
                  React.createElement "label",
                    htmlFor: option.view_id,
                    React.createElement "span", {},
                      React.createElement "p", {}, option.description

  renderRadioRadioQuestion: (item) ->
    deselectableClass = if item.deselectable then "deselectable" else ""
    answerGiven = @state.answers[item.key].value

    React.createElement "div",
      className: "fields",
      _.map item.options, (option, optionIdx) =>
        React.createElement "div",
          className: "option",
          key: option.view_id,
          htmlFor: item.key,
          React.createElement "div",
            className: "radiocheckwrapper",
            React.createElement "input",
              type: "radio",
              value: option.value,
              name: item.key,
              id: option.view_id,
              className: "radio #{deselectableClass}",
              checked: answerGiven == option.value,
              onClick: @handleAnswerChange
          React.createElement "div",
            className: "labelwrapper",
            React.createElement "label",
              htmlFor: option.view_id,
              React.createElement "span", {},
                React.createElement "p", {}, option.description

  renderFloatQuestion: (item, panelIdx, itemIdx) ->
    answer = @state.answers[item.key]
    # console.log "renderFloatQuestion", item, answer
    errorDiv = if answer.error
      errorClass =
        _.chain(answer.errorMessages)
         .keys()
         .join " "
         .value()
      errorMessages =
        _.chain(answer.errorMessages)
         .values()
         .join " "
         .value()
      React.createElement "div",
        className: "error #{errorClass}",
        errorMessages
    else
      React.createElement "div", className: "hidden", ""

    errorClass = if answer.error then "errors" else ""
    hiddenClass = if not answer.visible then "hidden" else ""

    React.createElement "div",
      key: "item#{panelIdx}-#{itemIdx}",
      className: "item #{item.type} vertical #{errorClass} #{hiddenClass}",
      errorDiv,
      React.createElement "div",
        className: "main",
        React.createElement "label",
          dangerouslySetInnerHTML:
            __html: item.title
      React.createElement "div",
        className: "description-and-fields",
        React.createElement "div",
          className: "description",
          item.description
        React.createElement "div",
          className: "fields",
          React.createElement "input",
            className: "float",
            size: 3,
            autoComplete: "off",
            type: "text",
            name: item.key,
            value: answer.value or "",
            onCange: @handleAnswerChange
          React.createElement "span",
            className: "unit",
            item.unit

  renderIntegerQuestion: (item, panelIdx, itemIdx) ->
    answer = @state.answers[item.key]
    # console.log "renderIntegerQuestion", item, answer
    errorDiv = if answer.error
      errorClass =
        _.chain(answer.errorMessages)
         .keys()
         .join " "
         .value()
      errorMessages =
        _.chain(answer.errorMessages)
         .values()
         .join " "
         .value()
      React.createElement "div",
        className: "error #{errorClass}",
        errorMessages
    else
      React.createElement "div", className: "hidden", ""

    errorClass = if answer.error then "errors" else ""
    hiddenClass = if not answer.visible then "hidden" else ""

    React.createElement "div",
      key: "item#{panelIdx}-#{itemIdx}",
      className: "item #{item.type} vertical #{errorClass} #{hiddenClass}",
      errorDiv,
      React.createElement "div",
        className: "main",
        React.createElement "label",
          dangerouslySetInnerHTML:
            __html: item.title
      React.createElement "div",
        className: "description-and-fields",
        React.createElement "div",
          className: "description",
          item.description
        React.createElement "div",
          className: "fields",
          React.createElement "input",
            className: "integer",
            size: 3,
            autoComplete: "off",
            type: "text",
            name: item.key,
            value: answer.value or "",
            onChange: @handleAnswerChange
          React.createElement "span",
            className: "unit",
            item.unit