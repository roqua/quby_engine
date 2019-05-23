# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::Entities
  module Charting
    describe Plottable do
      it 'stores the key' do
        score = Plottable.new(:tot)
        expect(score.key).to eq :tot
      end

      it 'stores the questionnaire_key' do
        score = Plottable.new(:tot, questionnaire_key: 'qkey')
        expect(score.questionnaire_key).to eq 'qkey'
      end

      it 'stores the label' do
        score = Plottable.new(:tot, label: 'Label')
        expect(score.label).to eq 'Label'
      end

      it 'has a default plotted key' do
        expect(Plottable.new(:tot).plotted_key).to eq :value
      end

      it 'stores the plotted key' do
        score = Plottable.new(:tot, plotted_key: :tscore)
        expect(score.plotted_key).to eq :tscore
      end

      it 'stores a global flag' do
        score = Plottable.new(:tot, global: true)
        expect(score.global).to be_truthy
      end
    end
  end
end
