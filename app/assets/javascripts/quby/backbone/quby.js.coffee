#= require_self
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

# Backbone bare models/collections without a marionette application
@Quby = {}
@Quby.Models = {}
@Quby.Collections = {}
@Quby.Views = {}

$ ->
  questions = new Quby.Collections.Questions
  $(".item.radio").each (index, element) ->
    options = new Quby.Collections.QuestionOptions
    $(element).find("input [value!='DESELECTED_RADIO_VALUE']").each (index, element) ->
      option = new Quby.Models.QuestionOption
      optionView = new Quby.Views.QuestionOptionView(model: option, el: element)
      options.add option
    questions.add new Quby.Models.Question(options: options)

#    questions.each ->
