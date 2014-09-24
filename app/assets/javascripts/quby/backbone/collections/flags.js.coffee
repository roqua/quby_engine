class Quby.Collections.Flags extends Backbone.Collection
  model: Quby.Models.Flag
  initShowsHides: (allQuestions) ->
    @.each (flag) =>
      flag.initShowsHides(allQuestions)