# frozen_string_literal: true

require 'spec_helper'

feature 'Large questionnaires', benchmark: true do
  scenario 'should be fast to build from DSL' do
    Quby::Questionnaires::DSL.build('vlq') do
      title 'VLQ'

      (1..2000).each do |i|
        question :"v_#{i}", type: :radio do
          title "Question #{i}"
          (1..10).each do |j|
            option :"a#{j}", value: j, description: "Q#{i} Option #{j}"
          end
        end
      end
    end
  end
end
