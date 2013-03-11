class Quby.Models.Question extends Backbone.Model
  defaults: ->
    hiddenByOptions: new Quby.Collections.QuestionOptions
    shownByOptions: new Quby.Collections.QuestionOptions
  hidden: ->
    (@get("hiddenByOptions").length > 0) && (@get("shownByOptions").length == 0)
