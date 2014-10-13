class Textvars
  constructor: (initial = {}) ->
    _.extend @, Backbone.Events
    @vars = initial

  get: (key) ->
    @vars[key] || "{{#{key}}}"

  set: (key, value) ->
    @vars[key] = value
    @trigger 'change'

Textvar = React.createClass
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

$ ->
  window.Quby ?= {}
  Quby.textvars = new Textvars(window.text_vars)

  $("span[text_var]").each (idx, elm) ->
    text_var = elm.getAttribute('text_var')
    React.renderComponent(Textvar(text_var: text_var), elm)

  # input[text_var]:change: set contents of all spans with same text_var to value
  $(document).on "change", "input[text_var]", ->
    Quby.textvars.set(@getAttribute("text_var"), @value)

  $("input[text_var][value][value!=\"\"]").trigger "change"
