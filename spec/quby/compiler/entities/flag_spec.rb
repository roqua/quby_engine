# frozen_string_literal: true

require 'spec_helper'

module Quby::Compiler::Entities
  describe Flag do
    let(:flag) do
      # the flag key is prefixed in lib/quby/questionnaires/entities/questionnaire.rb:232, unless internal
      described_class.new(key: :questkey_flagkey,
                          internal: false,
                          description: 'test flag',
                          description_true: 'flag is true',
                          description_false: 'flag is false',
                          trigger_on: true,
                          shows_questions: [],
                          hides_questions: [],
                          depends_on: :other_flag,
                          default_in_interface: false)
    end

    describe '#to_codebook' do
      it 'exports the flag key' do
        expect(flag.to_codebook).to include('questkey_flagkey')
      end
      it 'exports the description' do
        expect(flag.to_codebook).to include('test flag')
      end
      it 'contains the true_description' do
        expect(flag.to_codebook).to include('flag is true')
      end
      it 'contains the false_description' do
        expect(flag.to_codebook).to include('flag is false')
      end
      it 'contains the general blank description' do
        expect(flag.to_codebook).to include('\'\' (leeg) - Vlag niet ingesteld, informatie onbekend')
      end
      it 'requires either both description_true and false or a description' do
        error = "Flag 'test' Requires at least either both description_true and description_false or a description"
        expect { described_class.new(key: :test) }.to raise_exception(error)
        expect { described_class.new(key: :test, description_true: 'test true') }.to raise_exception(error)
        expect { described_class.new(key: :test, description_false: 'test false') }.to raise_exception(error)
        expect { described_class.new(key: :test, description: 'test') }.to_not raise_exception
      end
    end
    describe '#variable_description' do
      it 'returns a single line description of the flag' do
        expect(flag.variable_description).to eq("test flag (true - 'flag is true', false - 'flag is false')")
      end
    end
  end
end
