require 'spec_helper'

feature 'Quby questionnaires public API' do
  scenario 'find a questionnaire' do
    expect(Quby.questionnaires.find('simple').key).to eq('simple')
  end

  scenario 'check whether a questionnaire exists' do
    expect(Quby.questionnaires.exists? 'simple').to be_true
    expect(Quby.questionnaires.exists? 'inexistant_questionnaire').to be_false
  end

  scenario 'find all questionnaires' do
    expect(Quby.questionnaires.all.map(&:key)).to include('simple')
    expect(Quby.questionnaires.all.map(&:key)).to include('simple_with_outcome')
  end
end
