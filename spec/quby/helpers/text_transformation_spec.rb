require 'spec_helper'

module Quby
  describe AnswersHelper do

    let(:described_instance) do
      class TestClass include Quby::AnswersHelper end
      TestClass.new
    end

    describe '#link_html' do
      it 'returns an anchor tag' do
        expected_text = "<a href='#' onclick='modalFrame(\"http://google.com\");'>google</a>"
        expect(described_instance.link_html('http://google.com', 'google')).to eq(expected_text)
      end
    end

    describe '#textvar_html' do
      it 'returns a span with the textvar attributes' do
        expected_text = "<span class='textvar' textvar='test'>{{test}}</span>"
        expect(described_instance.textvar_html('test')).to eq(expected_text)
      end
    end

    describe '#transform_special_text' do
      it 'transforms links' do
        expected_text = "<a href='#' onclick='modalFrame(\"http://google.com\");'>google</a>"
        expect(described_instance.transform_special_text('~~http://google.com~~google~~')).to eq(expected_text)
      end
      it 'transforms textvars' do
        expected_text = "<span class='textvar' textvar='test'>{{test}}</span>"
        expect(described_instance.transform_special_text('{{test}}')).to eq(expected_text)
      end
      # rubocop:disable LineLength
      it 'transforms double textvars' do
        expected_text = "<span class='textvar' textvar='test'>{{test}}</span><span class='textvar' textvar='test2'>{{test2}}</span>"
        expect(described_instance.transform_special_text('{{test}}{{test2}}')).to eq(expected_text)
      end

      it 'transforms mixtures of textvar and link' do
        expected_text = "<a href='#' onclick='modalFrame(\"http://google.com\");'><span class='textvar' textvar='google'>{{google}}</span></a>"
        expect(described_instance.transform_special_text("~~http://google.com~~{{google}}~~")).to eq(expected_text)
      end
    end
  end
end
