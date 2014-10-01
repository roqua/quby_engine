class Quby.Collections.Flags extends Backbone.Collection
  model: Quby.Models.Flag
  initShowsHides: (allQuestions) ->
    @.each (flag) =>
      flag.initShowsHides(allQuestions)

  addFlags: (flag_definitions, flag_values) ->
    _.each _.pairs(flag_definitions), ([flagkey, flag]) =>
      bb_flag =
        value: flag_values[flagkey]
        key: flagkey
        hidesQuestionsKeys: flag.hides_questions
        showsQuestionsKeys: flag.shows_questions
        triggerOn: flag.trigger_on
      @.add(bb_flag)
