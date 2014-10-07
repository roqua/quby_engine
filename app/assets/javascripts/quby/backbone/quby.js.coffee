#= require_self
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./logic

# Backbone bare models/collections without a marionette application
@Quby = {}
Quby.Models = {}
Quby.Collections = {}
Quby.Views = {}
Quby.Logic = {}

$ ->
  Quby.questions = new Quby.Collections.Questions
  Quby.panels = new Quby.Collections.Panels
  Quby.flags = new Quby.Collections.Flags

Quby.initShowsHides = ->
  Quby.questions.trigger("initShowsHides")
  Quby.flags.initShowsHides(Quby.questions)