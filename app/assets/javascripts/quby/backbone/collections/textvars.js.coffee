class Quby.Collections.Textvars
  constructor: (initial = {}) ->
    _.extend @, Backbone.Events
    @vars = initial

  get: (key) ->
    @vars["#{Quby.questionnaire_key}_#{key}"] || "{{#{key}}}"

  set: (key, value) ->
    @vars[key] = value
    @trigger 'change'
