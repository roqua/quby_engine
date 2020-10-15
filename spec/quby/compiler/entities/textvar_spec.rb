# frozen_string_literal: true

require 'spec_helper'

module Quby::Compiler::Entities
  describe Textvar do
    describe '#to_codebook' do
      let(:textvar) do
        # key is prefixed in lib/quby/questionnaires/entities/questionnaire.rb:248
        described_class.new key: :questkey_textvarkey, description: 'textvar description'
      end

      it 'exports the textvar key' do
        expect(textvar.to_codebook).to include('questkey_textvarkey')
      end
      it 'contains the description' do
        expect(textvar.to_codebook).to include('textvar description')
      end
    end
  end
end
