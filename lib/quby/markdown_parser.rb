# frozen_string_literal: true

require 'quby/answers/services/text_transformation'
require 'redcarpet'

module Quby
  class MarkdownParser
    include Quby::TextTransformation

    def initialize(source)
      @source = source || ""
    end

    def to_html
      parser = Redcarpet::Markdown.new(HTMLWithPants.new)
      rc_html = parser.render(@source).strip
      rc_html = Nokogiri::HTML.fragment(rc_html).to_xhtml

      transform_special_text(rc_html)
    end

    def html_safe
      to_html.html_safe
    end
  end

  class HTMLWithPants < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end
end
