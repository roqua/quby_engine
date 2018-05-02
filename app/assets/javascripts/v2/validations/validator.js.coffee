class @Validator
  @get: (validation) ->
    switch validation.type
      when "requires_answer" then new RequiresAnswerValidator(validation)
      when "valid_integer" then new ValidIntegerValidator(validation)
      when "valid_float" then new ValidFloatValidator(validation)
      when "valid_date" then new ValidDateValidator(validation)
      when "minimum" then new MinimumValidator(validation)
      when "maximum" then new MaximumValidator(validation)

class RequiresAnswerValidator
  validate: (answer) ->
    error = _.isNull(answer.value)
    if error
      answer.error = true
      answer.errorMessages["requires_answer"] = "Deze vraag moet beantwoord worden."
    answer

class ValidIntegerValidator
  validate: (answer) ->
    error = not _.isInteger(answer.value)
    if error
      answer.error = true
      answer.errorMessages["valid_integer"] = "Dit moet een geheel getal zijn."
    answer

class ValidFloatValidator
  validate: (answer) ->
    error = not _.isNumber(answer.value)
    if error
      answer.error = true
      answer.errorMessages["valid_float"] = "Uw antwoord moet een getal zijn (gebruik een punt voor decimale getallen, geen komma)."
    answer

class ValidDateValidator
  validate: (answer) ->
    error = not _.isDate(answer.value)
    if error
      answer.error = true
      answer.errorMessages["valid_date"] = "Dit moet een datum zijn."
    answer

class MinimumValidator
  constructor: (@attrs) ->

  validate: (answer) ->
    switch @attrs.subtype
      when "number"
        if answer.value < @attrs.value
          answer.error = true
          answer.errorMessages["minimum"] = "Uw antwoord moet een getal groter dan of gelijk aan #{@attrs.value} zijn."
      when "date" then true # TODO!
    answer

class MaximumValidator
  constructor: (@attrs) ->

  validate: (answer) ->
    switch @attrs.subtype
      when "number"
        if answer.value > @attrs.value
          answer.error = true
          answer.errorMessages["maximum"] = "Uw antwoord moet een getal kleiner dan of gelijk aan #{@attrs.value} zijn."
      when "date" then true # TODO!
    answer
