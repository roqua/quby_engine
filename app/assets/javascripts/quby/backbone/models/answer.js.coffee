class Quby.Models.Answer
  constructor: (@fields = {}) ->

  getField: (key) ->
    @fields[key]

  setField: (key, value) ->
    @fields[key] = value
