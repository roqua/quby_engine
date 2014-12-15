require 'spec_helper'

describe 'Styling with custom CSS' do
  describe 'with css in the questionnaire definition', js: true do
    it 'passes the css on to the browser verbatim' do
      questionnaire = inject_questionnaire("test", <<-END)
        title 'Test questionnaire'

        css ".panel:before { content: 'special content from css'; }"

        panel do
          question :v_1, type: :string, title: 'Whodunnit?'
        end
      END

      visit_new_answer_for(questionnaire)
      expect(page).to have_content("Whodunnit")
      expect(page.body).to include(".panel:before { content: 'special content from css'; }")
    end
  end
end
