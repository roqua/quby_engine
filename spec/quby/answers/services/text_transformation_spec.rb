require 'spec_helper'

module Quby
  describe TextTransformation do

    let(:described_instance) do
      class TestClass include Quby::TextTransformation end
      TestClass.new
    end

    describe '#link_html' do
      it 'returns an anchor tag' do
        expected_text = "<a href='#' onclick='modalFrame(\"http://roqua.nl\");'>roqua</a>"
        expect(described_instance.link_html('http://roqua.nl', 'roqua')).to eq(expected_text)
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
        expected_text = "<a href='#' onclick='modalFrame(\"http://roqua.nl\");'>roqua</a>"
        expect(described_instance.transform_special_text('~~http://roqua.nl~~roqua~~')).to eq(expected_text)
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

      it 'transforms double links' do
        expected_text = "<a href='#' onclick='modalFrame(\"http://roqua.nl\");'>roqua</a> <a href='#' onclick='modalFrame(\"http://roqua.nl\");'>roqua</a>"
        expect(described_instance.transform_special_text('~~http://roqua.nl~~roqua~~ ~~http://roqua.nl~~roqua~~')).to eq(expected_text)
      end

      it 'transforms mixtures of textvar and link' do
        expected_text = "<a href='#' onclick='modalFrame(\"http://roqua.nl\");'><span class='textvar' textvar='roqua'>{{roqua}}</span></a>"
        expect(described_instance.transform_special_text("~~http://roqua.nl~~{{roqua}}~~")).to eq(expected_text)
      end
    end
  end
end
