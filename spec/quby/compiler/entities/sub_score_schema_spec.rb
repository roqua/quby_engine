require 'spec_helper'

module Quby::Compiler::Entities
  describe SubscoreSchema do
    let(:key) { :totaal }
    let(:export_key) { :tot }
    let(:options) { {key: key, export_key: export_key, label: 'Somscore'} }
    subject { SubscoreSchema.new options }

    it 'is valid' do
      expect(subject).to be_valid
    end

    describe 'if key is not a symbol' do
      let(:key) { 'totaal' }
      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors.full_messages).to eq(["Key is not a symbol"])
      end
    end

    describe 'if export_key is not a symbol' do
      let(:export_key) { 'tot' }
      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors.full_messages).to eq(["Export key is not a symbol"])
      end
    end
  end
end
