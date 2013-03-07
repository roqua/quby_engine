#= require_self
#= require_tree ./models
#= require_tree ./collections

# Set default locale for I18n
I18n.defaultLocale = "nl"

Backbone.Marionette.Renderer.render = (template, data) ->
  if !JST[template]
    throw "Template '" + template + "' not found!"
  JST[template](data);

# Backbone Application
@Quby = new Backbone.Marionette.Application
@Quby.Models = {}
@RoQua.Collections = {}
#@RoQua.Routers = {}
#@RoQua.Views = {}
#@RoQua.Viewmodels = {}

RoQua.addInitializer (options) ->
  RoQua.addRegions(content: "#content")
#  controller = new Devtool.Controllers.TimelineItems
#  new Devtool.Routers.Discussions(controller: controller)
#  Backbone.history.start()

$(document).ready ->
  Quby.start()

