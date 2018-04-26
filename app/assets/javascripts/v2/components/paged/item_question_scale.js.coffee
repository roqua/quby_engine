class @ItemQuestionScale extends React.Component
  displayName: "ItemQuestionScale"

  render: ->
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
                    onClick: @handleAnswerChange
                  React.createElement "label",
                    htmlFor: option.view_id,
                    React.createElement "span", {},
                      React.createElement "p", {}, option.description
