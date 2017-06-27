require 'quby/answers/services/text_transformation'
require 'kramdown'

module Quby
  class MarkdownParser
    include Quby::TextTransformation

    def initialize(source)
      @source = source || ""
    end

    def to_html
      html = ::Kramdown::Document.new(@source, entity_output: :numeric).to_html.chomp
      transform_special_text(html)
    end

    def html_safe
      to_html.html_safe
    end
  end
end
