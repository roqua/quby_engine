class Quby.Collections.Flags extends Backbone.Collection
  model: Quby.Models.Flag
  initShowsHides: (allQuestions) ->
    @.each (flag) =>
      flag.initShowsHides(allQuestions)

  addFlags: (flag_definitions, flag_values) ->
    _.each _.pairs(flag_definitions), ([flagkey, flag]) =>
      flag.value = flag_values[flagkey]
      @.add(flag)
