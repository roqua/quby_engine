# frozen_string_literal: true

require 'spec_helper'

feature 'tables', js: true do
  scenario 'tables with radios' do
    questionnaire = inject_questionnaire("test", <<-END)
      custom_method :wonen_vraag do |key, options = {}|
        text "\#{options[:hulpverlener]}", col_span: 3

        question "\#{key}a".to_sym, type: :radio, col_span: 2, **options do
          option :a1, value: 1, description: "Ja"
          option :a0, value: 0, description: "Nee"
        end
        question "\#{key}b".to_sym, type: :integer, col_span: 2, **options do
          size "2"
          validates_in_range 1..92
        end
      end

      panel do
        title "Foo"

        table columns: 7, show_option_desc: true do
          text "", col_span: 3
          text "*Contact gehad?*", col_span: 2
          text "*Totaal aantal contacten* <sup>1.</sup>", col_span: 2
          wonen_vraag :v_24, instelling: "Foo", hulpverlener: "*A*"
          wonen_vraag :v_25, instelling: "Foo", hulpverlener: "*B*"
          wonen_vraag :v_26, instelling: "Foo", hulpverlener: "*C*"
          wonen_vraag :v_27, instelling: "Foo", hulpverlener: "*D*"
        end
      end
    END

    answer = create_new_answer_for(questionnaire)
    visit_new_answer_for(questionnaire, 'paged', answer)
    expect(page).to have_content 'Foo'
  end
end