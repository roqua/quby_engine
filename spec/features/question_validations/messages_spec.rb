require 'spec_helper'

feature 'Validation messages' do
  describe 'validation message rendering' do
    before do
      visit_new_answer_for(Quby.questionnaires.find('all_validations'))
      click_on "Klaar"
    end

    expected_errors = {
      maximum: 'Uw antwoord moet een getal kleiner dan of gelijk aan 10 zijn.',
      minimum: 'Uw antwoord moet een getal groter dan of gelijk aan 10 zijn.',
      requires_answer: 'Deze vraag moet beantwoord worden.',
      regexp: 'Uw antwoord moet voldoen aan de vorm (?-mix:a).',
      valid_integer: 'Uw antwoord moet een afgerond getal zijn.',
      valid_float: 'Uw antwoord moet een getal zijn (gebruik een decimale punt voor kommagetallen).',
      valid_date: 'Vul een geldige datum in met formaat DD-MM-JJJJ, bijvoorbeeld 13-08-2015',
      too_many_checked: 'U heeft te veel opties gekozen.',
      not_all_checked: 'U heeft te weinig opties gekozen.',
      maximum_checked_allowed: 'U mag maximaal 1 optie kiezen.',
      minimum_checked_required: 'U moet minstens 3 opties kiezen.',
      answer_group_minimum: 'Beantwoord minstens 1 van deze vragen',
      answer_group_maximum: 'Beantwoord hoogstens 1 van deze vragen'
    }

    expected_errors.each do |validation_key, expected_message|
      scenario validation_key do
        expect(first(".error.#{validation_key}")).to have_content expected_message
      end
    end
  end
end
