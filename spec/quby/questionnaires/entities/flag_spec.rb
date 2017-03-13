require 'spec_helper'

module Quby::Questionnaires::Entities
  describe Flag do
    describe '#to_codebook' do
      let(:flag) do
        # the flag key is prefixed in lib/quby/questionnaires/entities/questionnaire.rb:231 ,unless internal
        described_class.new(key: :questkey_flagkey,
                            internal: false,
                            description_true: 'flag is true',
                            description_false: 'flag is false')
      end

      it 'exports the flag key' do
        expect(flag.to_codebook).to include('questkey_flagkey')
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
    end
  end
end
