require 'spec_helper'

module Quby::Questionnaires::DSL
  describe Helpers do
    let(:questionnaire) { Quby::Questionnaires::Entities::Questionnaire.new("example") }
    let(:builder) { QuestionnaireBuilder.new(questionnaire) }

    # this helper has some extra tests to check that helpers are included everywhere
    describe '.image_tag' do
      let(:expected_html) { "<img alt='Happy-face' src='/assets/quby/happy-face.png' />" }

      it 'builds image tags outside of panels' do
        dsl { text image_tag('quby/happy-face.png') }
        expect(questionnaire.panels.first.items.first.text).to eq(expected_html)
      end

      it 'builds image tags inside of panels' do
        dsl do
          panel do
            text image_tag('quby/happy-face.png')
          end
        end

        expect(questionnaire.panels.first.items.first.text).to eq(expected_html)
      end

      it 'builds image tags inside of questions' do
        # this one is different because markdown/maruku transforms double quotes into single quotes
        # and question descriptions are not passed through markdown/maruku
        expected_html = "<img alt=\"Happy-face\" src=\"/assets/quby/happy-face.png\" />"
        dsl do
          panel do
            question :v_1, type: :radio do
              option :a1, description: image_tag('quby/happy-face.png')
            end
          end
        end
        expect(questionnaire.panels.first.items.first.options.first.description).to eq(expected_html)
      end
    end

    def dsl(&block)
      builder.instance_eval(&block)
    end
  end
end
