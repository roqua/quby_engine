# frozen_string_literal: true

require 'spec_helper'

module Quby::Answers::Entities
  describe Outcome do
    describe '#action' do
      it 'returns :alarm if any score is alarming' do
        outcome = Outcome.new(scores: {tot: {label: "Totaal", value: 10, status: "alarm"},
                                       soc: {label: "Sociaal", value: 5, status: "attention"}})
        outcome.action.should eq :alarm
      end

      it 'returns :alarm if an answer to a question is alarming' do
        outcome = Outcome.new(actions: {alarm: [:v_1]})
        outcome.action.should eq :alarm
      end

      it 'returns :attention if nothing is alarming and score is attention-worthy' do
        outcome = Outcome.new(scores: {tot: {label: 'Totaal', value: 10, status: "attention"}})
        outcome.action.should eq :attention
      end

      it 'returns :attention if nothing is alarming and an answer to a question is attention-worthy' do
        outcome = Outcome.new(actions: {alarm: [], attention: [:v_1]})
        outcome.action.should eq :attention
      end

      it 'returns nil if all scores and answers are neither alarming nor attention-worthy' do
        outcome = Outcome.new(scores: {tot: {label: 'Totaal', value: 10}},
                              actions: {alarm: [], attention: []})
        outcome.action.should be_nil
      end

      it 'works with symbols as well as keys for score statusses' do
        outcome = Outcome.new(scores: {tot: {label: "Totaal", value: 10, status: :alarm},
                                       soc: {label: "Sociaal", value: 5, status: "attention"}})
        outcome.action.should eq :alarm
      end
    end
  end
end
