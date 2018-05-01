class @Validator
  @get: (type) ->
    switch type
      when "requires_answer" then new RequiredValidator

class RequiredValidator
  validate: (answer) ->
    error = _.isNull(answer.value)
    errorMessage = "Deze vraag moet beantwoord worden."
    if error
      answer.error = true
      answer.errorMessages["requires_answer"] = errorMessage
    answer
