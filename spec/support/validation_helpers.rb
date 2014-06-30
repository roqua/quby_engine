module ClientSideValidationHelpers
  def self.included(base)
    base.let(:validation_run_location) { :client_side }
    base.before { @answer = visit_new_answer_for(questionnaire) }
  end

  def fill_in_question(question_key, value)
    within '#panel0.current' do
      fill_in "answer_#{question_key}", with: value
    end
  end

  def select_radio_option(question_key, option_key)
    within '#panel0.current' do
      choose "answer_#{question_key}_#{option_key}"
    end
  end

  def deselect_radio_option(question_key, option_key)
    within '#panel0.current' do
      find(:input, "#answer_#{question_key}_#{option_key}").click
      page.should have_no_checked_field("answer_#{question_key}_#{option_key}")
    end
  end

  def check_option(option_key)
    within '#panel0.current' do
      check "answer_#{option_key}"
    end
  end

  def uncheck_option(option_key)
    within '#panel0.current' do
      uncheck "answer_#{option_key}"
    end
  end

  def select_select_option(question_key, option_key)
    within '#panel0.current' do
      value_text = find("#answer_#{question_key}_#{option_key}").text
      select value_text, from: "answer[#{question_key}]"
    end
  end

  def run_validations
    within '#panel0.current' do
      click_on 'Verder'
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
    unless @have_clicked_save
      click_on "Klaar"
      page.should have_content("Bedankt voor het invullen van deze vragenlijst. Uw antwoorden zijn opgeslagen.")
      @have_clicked_save = true
    end
    Quby.answers.reload(@answer).send(question_key).should eq(expected_value)
  end
end

module ServerSideValidationHelpers
  def self.included(base)
    base.let(:validation_run_location) { :server_side }
    base.let(:answer) { Quby.answers.create!(questionnaire.key) }
    base.let(:updates_answers) { Quby::Answers::Services::UpdatesAnswers.new(answer) }
    base.let(:answer_to_submit) { {} }
  end

  def fill_in_question(question_key, value)
    answer_to_submit[question_key] = value
  end

  def select_radio_option(question_key, option_key)
    answer_to_submit[question_key] = option_key
  end

  def deselect_radio_option(question_key, option_key)
    answer_to_submit[question_key] = nil
  end

  def check_option(option_key)
    answer_to_submit[option_key] = '1'
  end

  def uncheck_option(option_key)
    answer_to_submit[option_key] = '0'
  end

  def select_select_option(question_key, option_key)
    answer_to_submit[question_key] = option_key
  end

  def run_validations
    answer.errors.clear
    updates_answers.update(answer_to_submit)
  end

  def expect_no_errors
    answer.errors.should be_empty
  end

  def expect_saved_value(question_key, expected_value)
    Quby.answers.reload(answer).send(question_key).should eq(expected_value)
  end

  def expect_error_on(question_key, error_type)
    answer.errors[question_key].map { |error| error[:valtype].to_s }.should include(error_type.to_s)
  end
end
