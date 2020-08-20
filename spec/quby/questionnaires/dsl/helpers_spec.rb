# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::DSL
  describe Helpers do
    let(:questionnaire) { Quby::Questionnaires::Entities::Questionnaire.new("example") }
    let(:builder) { QuestionnaireBuilder.new(questionnaire) }

    # this helper has some extra tests to check that helpers are included everywhere
    describe '.image_tag' do
      let(:expected_html) { %r{<p><img alt=\"Happy face\" src=\"/assets/quby/happy-face.*.png\" /></p>} }

      it 'builds image tags outside of panels' do
        dsl { text image_tag('quby/happy-face.png') }
        expect(questionnaire.panels.first.items.first.text).to match(expected_html)
      end

      it 'builds image tags inside of panels' do
        dsl do
          panel do
            text image_tag('quby/happy-face.png')
          end
        end

        expect(questionnaire.panels.first.items.first.text).to match(expected_html)
      end

      it 'builds image tags inside of questions' do
        # this one is different because markdown/maruku transforms double quotes into single quotes
        # and question descriptions are not passed through markdown/maruku
        expected_html = %r{<img .*?src="/assets/quby/happy-face.*.png"}
        dsl do
          panel do
            question :v_1, type: :radio do
              option :a1, description: image_tag('quby/happy-face.png')
            end
          end
        end
        expect(questionnaire.panels.first.items.first.options.first.description).to match(expected_html)
      end
    end

    describe 'video_tag' do
      it 'makes a text item with a html 5 video player for the given video source urls' do
        html = builder.video_tag 'https://www.example.com/video.mp4', 'https://www.example.com/video.webm'

        expect(html).to \
          eq("<video width=\"100%\" preload=\"none\" controls=\"controls\"><source src=\"https://www.example.com/video.mp4\" type=\"video/mp4\">\
<source src=\"https://www.example.com/video.webm\" type=\"video/webm\">\
Helaas kan je browser dit filmpje niet afspelen. Probeer een andere browser te gebruiken.</video>")
      end

      it 'can add a autoplay attribute (with muted added to allow chrome autoplay)' do
        html = builder.video_tag 'https://www.example.com/video.mp4', autoplay: true

        expect(html).to \
          include('<video width="100%" preload="none" autoplay="autoplay" muted="muted" controls="controls">')
      end

      it 'can add a loop attribute' do
        html = builder.video_tag 'https://www.example.com/video.mp4', loop: true

        expect(html).to \
          include('<video width="100%" preload="none" loop="loop" controls="controls">')
      end

      it 'can add a poster url' do
        html = builder.video_tag 'https://www.example.com/video.mp4', poster: 'https://www.example.com/poster.jpg'

        expect(html).to \
          include('<video width="100%" preload="none" poster="https://www.example.com/poster.jpg" controls="controls">')
      end
    end

    def dsl(&block)
      builder.instance_eval(&block)
    end
  end
end
