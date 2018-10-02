# frozen_string_literal: true

require 'spec_helper'

shared_examples 'validations on scale questions' do
  before do
    allow_server_side_validation_error
  end
  context 'requires_answer validation' do
    let(:questionnaire) do
      inject_questionnaire "test", <<-END
        question :v_scale, type: :scale, required: true do
          title "Pick one"
          option :a1, value: 1, description: 'Unicorns'
          option :a2, value: 2, description: 'Rainbows'
        end; end_panel
      END
    end

    scenario 'saving a valid choice' do
      select_radio_option 'v_scale', 'a1'
      run_validations
      expect_no_errors
      expect_saved_value 'v_scale', 'a1'
    end

    scenario 'saving with an unknown scale chosen' do
      next if validation_run_location == :client_side

      # TODO: Is this the behaviour we really want?
      select_radio_option 'v_scale', 'aXX'
      run_validations
      expect_no_errors
      expect_saved_value 'v_scale', 'aXX'
    end

    scenario 'saving without a choice' do
      run_validations
      expect_error_on 'v_scale', 'requires_answer'
    end
  end
end

feature 'Client-side validations on scale questions', js: true do
  include ClientSideValidationHelpers
  it_behaves_like "validations on scale questions"
end

feature 'Server-side validations on scale questions' do
  include ServerSideValidationHelpers
  it_behaves_like "validations on scale questions"
end
