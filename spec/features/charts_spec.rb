# frozen_string_literal: true

require 'spec_helper'

feature 'Defining charts in a questionnaire' do

  let(:questionnaire_with_chart) { Quby.questionnaires.find('questionnaire_with_chart') }

  it 'has a chart with plottables' do
    plottable_keys = questionnaire_with_chart.charts.first.plottables.map(&:key)
    expect(plottable_keys).to eq([:total, :v_1, :v_2, :v_3])
  end

  it 'has labels for each plottable' do
    plottable_labels = questionnaire_with_chart.charts.first.plottables.map(&:label)
    expect(plottable_labels).to eq(["Total", "Label 1", "Title 2", "Title 3"])
  end

  it 'has an overview' do
    expect(questionnaire_with_chart.charts.overview).to be_present
    expect(questionnaire_with_chart.charts.overview.y_max).to eq(100)
    expect(questionnaire_with_chart.charts.overview.subscore).to eq(:value)
  end

end
