class @Validator
  @get: (type) ->
    switch type
      when "requires_answer" then new RequiresAnswerValidator
      when "valid_integer" then new ValidIntegerValidator
      when "valid_float" then new ValidFloatValidator
      when "valid_date" then new ValidDateValidator

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
