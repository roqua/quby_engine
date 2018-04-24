class @Questionnaire extends React.Component
  displayName: "Questionnaire"

  constructor: (props) ->
    super props

    @handleAnswerChange = @handleAnswerChange.bind(@)

    @state =
      answers: @initialAnswerHash()

  initialAnswerHash: ->
    _.chain(@props.questionnaire.panels)
     .map (panel) -> panel.items
     .flatten()
     .map (item) -> item.key ? null
     .compact()
     .map (key) -> [key, null]
     .object()
     .value()

  handleAnswerChange: (ev) ->
    answers = @state.answers
    answers[ev.target.name] = parseInt(ev.target.value)
    @setState
      answers: answers

  render: ->
    panels = _.map @props.questionnaire.panels, (panel, panelIdx) =>
      React.createElement "fieldset", key: "panel#{panelIdx}", className: "panel",
        React.createElement "h1", {}, panel.title
        _.map panel.items, (item, itemIdx) =>
          switch item.class
            when "Quby::Questionnaires::Entities::Text" then @renderText item, panelIdx, itemIdx
            when "Quby::Questionnaires::Entities::Questions::RadioQuestion" then @renderRadioQuestion item, panelIdx, itemIdx
            else @renderText item, panelIdx, itemIdx


    React.createElement "form",
      className: @props.display_mode,
      panels

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

    React.createElement "div",
      key: "item#{panelIdx}-#{itemIdx}",
      className: "item #{item.type} horizontal",
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
    answerGiven = @state.answers[item.key]

    React.createElement "div",
      className: "fields",
      React.createElement "table",
        border: 0,
        cellSpacing: 0,
        React.createElement "tbody", {},
          React.createElement "tr", {},
            _.map item.options, (option, optionIdx) =>
              React.createElement "td",
                key: option.view_id,
                className: "option #{optionWidth}",
                htmlFor: item.key,
                React.createElement "span", {},
                  React.createElement "input",
                    type: "radio",
                    value: option.value,
                    name: item.key,
                    id: option.view_id,
                    className: "scale #{deselectableClass}",
                    checked: answerGiven == option.value,
                    onChange: @handleAnswerChange
                  React.createElement "label",
                    htmlFor: option.view_id,
                    React.createElement "span", {},
                      React.createElement "p", {}, option.description

  renderRadioRadioQuestion: (item) ->
    deselectableClass = if item.deselectable then "deselectable" else ""
    answerGiven = @state.answers[item.key]

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
              onChange: @handleAnswerChange
          React.createElement "div",
            className: "labelwrapper",
            React.createElement "label",
              htmlFor: option.view_id,
              React.createElement "span", {},
                React.createElement "p", {}, option.description
