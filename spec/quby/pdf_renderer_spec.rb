require 'spec_helper'

describe Quby::PdfRenderer do
  describe '#render_pdf' do
    it 'calls the html service with the given html string and returns the body' do
      expect(RestClient).to receive(:post).with(ENV['HTML_TO_PDF_URL'], 'nice').and_return(double(body: 'nice'))
      expect(described_class.render_pdf('nice')).to eq('nice')
    end

    it 'raises EmptyResponse if the response body is empty' do
      expect(RestClient).to receive(:post).with(ENV['HTML_TO_PDF_URL'], 'nice').and_return(double(body: ''))
      expect { described_class.render_pdf('nice') }.to raise_exception(described_class::EmptyResponse)
    end
  end
end

