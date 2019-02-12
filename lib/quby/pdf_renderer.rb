require 'fileutils'
require 'open3'

module PdfRenderer
  def self.render_pdf(html_str)
    RestClient.post(ENV['HTML_TO_PDF_URL'], html_str).body
  end
end
