Quby.Components.Textvar = React.createClass
  displayName: 'Textvar'

  componentDidMount: ->
    Quby.textvars.on 'change', @triggerUpdate

  componentWillUnmount: ->
    Quby.textvars.off 'change', @triggerUpdate

  triggerUpdate: ->
    if @isMounted()
      @forceUpdate()

  render: ->
    React.DOM.span {}, Quby.textvars.get(@props.text_var)
