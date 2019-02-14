require 'rest-client'

module Quby
  module PdfRenderer
    def self.render_pdf(html_str)
      RestClient.post(ENV['HTML_TO_PDF_URL'], html_str).body
    end
  end
end
