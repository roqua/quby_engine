module ClientSideValidationHelpers
  def fill_in_question(question_key, value)
    within '#panel0.current' do
      fill_in "answer_#{question_key}", with: value
    end
  end

  def check_option(option_key)
    within '#panel0.current' do
      check "answer_#{option_key}"
    end
  end

  def run_validations
    within '#panel0.current' do
      click_on 'Volgende vraag'
    end
  end

  def expect_no_errors
    expect(find('#panel1')).to be_visible
  end

  def expect_error_on(question_key, error_type)
    within '#panel0.current' do
      expect(find("#item_#{question_key} .error.#{error_type}")).to be_visible
    end
  end

  def expect_saved_value(question_key, expected_value)
    click_on "Klaar"
    page.should have_content("Bedankt voor het invullen van deze vragenlijst. Uw antwoorden zijn opgeslagen.")
    @answer.reload.send(question_key).should eq(expected_value)
  end
end

module ServerSideValidationHelpers
  def fill_in_question(question_key, value)
    answer_to_submit[question_key] = value
  end

  def check_option(option_key)
    answer_to_submit[option_key] = '1'
  end

  def run_validations
    answer.errors.clear
    updates_answers.update(answer_to_submit)
  end

  def expect_no_errors
    answer.errors.should be_empty
  end

  def expect_saved_value(question_key, expected_value)
    answer.reload.send(question_key).should eq(expected_value)
  end

  def expect_error_on(question_key, error_type)
    answer.errors[question_key].map { |error| error[:valtype].to_s }.should include(error_type.to_s)
  end
end