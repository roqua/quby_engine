# frozen_string_literal: true

require 'spec_helper'
module Quby
  describe 'Age in scores' do
    it 'can access age in a real score calculation' do
      answer  = Quby.answers.create!('aged_score_interpretations',
                                     patient: {"birthyear" => Time.zone.now.year - 18, "gender" => :male},
                                     observation_time: Time.now)

      outcome = Quby.answers.generate_outcome(answer)
      expect(outcome.scores).to eq({"tot" => {"label" => "Totaalscore",
                                          "value" => 10,
                                          "interpretation" => "Laag",
                                          "score" => true,
                                          "referenced_values" => []}})
    end
  end
end
