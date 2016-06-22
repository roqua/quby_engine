require 'spec_helper'
require 'benchmark'
# require 'flamegraph'

describe 'Benchmark making answer entities', benchmark: true do
  let(:definition) do
    pieces = []

    500.times do |i|
      pieces << <<-END
        question :v_#{i}, type: :radio, required: false do
          title "Choose"
          option :a1, value: 1, description: "Ja"
          option :a2, value: 2, description: "Nee"
        end
      END
    end

    pieces.join("\n\n")

  end

  let(:questionnaire) { inject_questionnaire("test", definition) }
  let!(:sample_count) { 1000 }

  it 'is quick for large questionnaires' do
    # initialize questionnaire outside profiler
    RubyProf.pause if RubyProf.running?
    questionnaire.questions
    expect(questionnaire.key).to eq('test')
    Quby::Answers::Entities::Answer.new(questionnaire_key: questionnaire.key).enhance_by_dsl
    RubyProf.resume if RubyProf.running?

    sample_count.times do
      Quby::Answers::Entities::Answer.new(questionnaire_key: questionnaire.key).enhance_by_dsl
    end
  end
end
