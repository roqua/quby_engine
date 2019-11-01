#= require_self
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./components

# Backbone bare models/collections without a marionette application
@Quby = {}
Quby.Models = {}
Quby.Collections = {}
Quby.Views = {}
Quby.Logic = {}
Quby.Components = {}

$ ->
  Quby.questions = new Quby.Collections.Questions
  Quby.panels = new Quby.Collections.Panels
  Quby.flags = new Quby.Collections.Flags

Quby.init = (options) ->
  Quby.questionnaire_key = options.questionnaire_key
  Quby.flags.addFlags(options.flag_definitions, options.flag_values)
  Quby.answer = new Quby.Models.Answer(options.answer_value)
  Quby.initTextvars(options.textvars)
  Quby.initShowsHides()
  Quby.initFieldListeners()

Quby.initTextvars = (textvars) ->
  Quby.textvars = new Quby.Collections.Textvars(textvars)

  # Convert textvars to React components
  $("span[textvar]").each (idx, elm) ->
    textvar = elm.getAttribute('textvar')
    React.renderComponent(Quby.Components.Textvar(textvar: textvar), elm)

  # Listen to changes of textvar inputs
  $(document).on "change", "input[sets_textvar]", ->
    Quby.textvars.set(@getAttribute("sets_textvar"), @value)

  # Initialize textvars from inputs once
  $("input[sets_textvar][value][value!=\"\"]").trigger "change"

Quby.initShowsHides = ->
  Quby.questions.trigger("initShowsHides")
  Quby.flags.initShowsHides(Quby.questions)

Quby.initFieldListeners = ->
  $("select[data-field-key], input[data-field-key], textarea[data-field-key]").on "change", (event) ->
    fieldKey = $(event.target).data("field-key")
    fieldValue = event.target.value
    Quby.answer.setField(fieldKey, fieldValue)
