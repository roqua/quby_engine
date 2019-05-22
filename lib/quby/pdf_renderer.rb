require 'rest-client'

module Quby
  module PdfRenderer
    class EmptyResponse < RuntimeError
    end
    def self.render_pdf(html_str)
      RestClient.post(ENV['HTML_TO_PDF_URL'], html_str).body.tap do |response|
        raise EmptyResponse if response.empty?
      end
    end
  end
end
