#= require_self
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

# Backbone bare models/collections without a marionette application
@Quby = {}
@Quby.Models = {}
@Quby.Collections = {}
@Quby.Views = {}
window.quby = @Quby
$ ->
  window.quby.questions = new Quby.Collections.Questions
  window.quby.panels = new Quby.Collections.Panels