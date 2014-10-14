#= require_self
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./components
#= require_tree ./logic

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
  Quby.flags.addFlags(options.flag_definitions, options.flag_values)
  Quby.initTextvars(options.textvars)
  Quby.initShowsHides()

Quby.initTextvars = (textvars) ->
  Quby.textvars = new Quby.Collections.Textvars(textvars)

  # Convert textvars to React components
  $("span[text_var]").each (idx, elm) ->
    text_var = elm.getAttribute('text_var')
    React.renderComponent(Quby.Components.Textvar(text_var: text_var), elm)

  # Listen to changes of textvar inputs
  $(document).on "change", "input[text_var]", ->
    Quby.textvars.set(@getAttribute("text_var"), @value)

  # Initialize textvars from inputs once
  $("input[text_var][value][value!=\"\"]").trigger "change"

Quby.initShowsHides = ->
  Quby.questions.trigger("initShowsHides")
  Quby.flags.initShowsHides(Quby.questions)
