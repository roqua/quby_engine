require 'spec_helper'

feature 'saving a question which key clashes with its parent option', js: true do
  let(:questionnaire) { Quby.questionnaires.find('subquestion_key_clash') }
  scenario 'saving should have the value end up in the raw params and in the value itself' do

    answer = create_new_answer_for(questionnaire)
    visit_new_answer_for(questionnaire, 'paged', answer)
    choose 'answer_v_0_a1'
    fill_in 'answer[v_0_a1]', with: 'clashing'
    click_on 'Klaar'
    page.should have_content("Bedankt voor het invullen van deze vragenlijst. Uw antwoorden zijn opgeslagen.")

    answer = Quby.send(:answer_repo).send(:all_records, 'subquestion_key_clash').last

    expect(answer.raw_params).to include(
      "aborted" => false,
      "v_0" => "a1",
      "v_0_a1" => "clashing"
    )
    expect(answer.value).to eq("v_0" => "a1",
                               'v_0_a1' => 'clashing')
  end
end
