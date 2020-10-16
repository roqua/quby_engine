require 'spec_helper'

describe Quby::Compiler::Outputs::QubyFrontendV1Serializer do
  it 'generates json' do
    questionnaire = dsl("test") { title "Test Quest" }
    serializer = described_class.new(questionnaire)
    expect(serializer.as_json).to include({
      key: "test",
      title: "Test Quest"
    })
  end


  def dsl(key, &block)
    Quby::Compiler::DSL.build(key, nil, &block)
  end
end