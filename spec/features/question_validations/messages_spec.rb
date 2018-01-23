require 'spec_helper'

feature 'Validation messages' do
  # NB only tests content of the validation messages, not the actual functioning of the validation
  describe 'validation message rendering' do
    expected_errors = {
      "maximum.number" => 'Uw antwoord moet een getal kleiner dan of gelijk aan 10 zijn.',
      "minimum.number" => 'Uw antwoord moet een getal groter dan of gelijk aan 10 zijn.',
      "minimum.date" => 'De datum moet op of na de dag 2 januari 2017 (2-1-2017) liggen.',
      "maximum.date" => 'De datum moet op of voor de dag 4 maart 2017 (4-3-2017) liggen.',
      requires_answer: 'Deze vraag moet beantwoord worden.',
      regexp: 'Uw antwoord moet voldoen aan de vorm (?-mix:a).',
      valid_integer: 'Uw antwoord moet een afgerond getal zijn.',
      valid_float: 'Uw antwoord moet een getal zijn (gebruik een punt voor decimale getallen, geen komma).',
      valid_date: 'Vul een geldige datum in met formaat DD-MM-JJJJ, bijvoorbeeld 13-08-2015',
      too_many_checked: 'U heeft te veel opties gekozen.',
      not_all_checked: 'U heeft te weinig opties gekozen.',
      maximum_checked_allowed: 'U mag maximaal 1 optie kiezen.',
      minimum_checked_required: 'U moet minstens 3 opties kiezen.',
      answer_group_minimum: 'Beantwoord minstens 1 van deze vragen',
      answer_group_maximum: 'Beantwoord hoogstens 1 van deze vragen'
    }

    expected_errors.each do |validation_key, expected_message|
      scenario validation_key, js: true do
        visit_new_answer_for(Quby.questionnaires.find('all_validations'))
        expect(page).to have_css ".error.#{validation_key}", visible: :hidden, text: expected_message
      end
    end
  end
end
